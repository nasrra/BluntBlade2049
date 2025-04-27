/// @description Insert description here
// You can write your code in this editor

target = obj_player;
weapon = undefined;
current_move_speed = move_speed;

function move(){
    if(movement_path_points == undefined || movement_path_point_index >= array_length(movement_path_points)){
        exit;
    }

    var point = movement_path_points[movement_path_point_index];
    var px = point[0];
    var py = point[1];

    var avoidance = 16;
    
    var other_enemy = instance_place(px, py, obj_enemy);
    if(other_enemy != noone && other_enemy.id != id && point_distance(other_enemy.x, other_enemy.y, px, py) <= avoidance){
        exit;
    } 

    var dir = point_direction(x,y,px,py);
    var dist = point_distance(x,y,px,py);

    var movement = min(move_speed, dist);

    x+=lengthdir_x(movement, dir);
    y+=lengthdir_y(movement, dir);
    if(dist < 1.0){
        movement_path_point_index += 1;
    }
}

function set_direction_to_target(){
    if(instance_exists(target)==false){
        exit;
    }    
    direction = point_direction(x,y,target.x,target.y);
}   

function update_weapon(){
    weapon.set_position(x,y);
    weapon.point_in_direction(direction);
    weapon.update_angle();
    weapon.draw();
	weapon.can_shoot = can_see_target();
}

function face_target(){
    if(direction >= 330 || direction <= 45){
        // show_debug_message("face_right");        
    }
    else if(direction >= 45 && direction <= 135){
        // show_debug_message("face_up");
    }
    else if(direction >= 135 && direction <= 225){
        // show_debug_message("face_left");
    }
    else if(direction >= 225 && direction <= 330){
        // show_debug_message("face_down");
    }
}


// make it so the path stops when knocking back enemies as they are hit by bullet.
movement_path = undefined;
movement_path_points = [];
movement_path_point_index = 1;
movement_path_alarm_index = 1;
function _update_movement_path(){
    if(instance_exists(target) == false)
        exit;

    delete_movement_path();

    movement_path = path_add();

    // update target position.
    var target_y = target.y;
    var target_x = target.x;

    // assign path to use for new pathing.
    mp_grid_path(obj_enemy_path_manager.grid, movement_path, x, y, target_x, target_y, 1);

    // path algoritm to generate path to point.
    // path_start(movement_path, current_move_speed, path_action_stop, true);

    movement_path_points = [];
    var points_count = path_get_number(movement_path);
    for(var i = 0; i < points_count; i++){
        var px = path_get_point_x(movement_path,i);
        var py = path_get_point_y(movement_path,i);
        array_push(movement_path_points, [px,py]);
    }

    movement_path_point_index = 1;

    alarm_set(movement_path_alarm_index, 60);
}

function delete_movement_path(){
    if(movement_path!=undefined){
        path_delete(movement_path);
    }
}

damage_flash = new sh_damage_flash_controller(id, c_white);
damage_particle = instance_create_layer(x,y,LAYER_ENEMY, obj_particle_system);
damage_particle.initialise(part_type_entity_damaged(), 0, 0);

function update_particles(){
    damage_particle.x = x;
    damage_particle.y = y;
}

function can_see_target(){
    if(instance_exists(target) == false){
        exit;
    }
    var flag = collision_line(x, y, target.x, target.y, obj_environment, true, true) == noone? true : false;
    if(collision_line(x, y, target.x, target.y, obj_dyn_environment, true, true) != noone){
        flag = true;
    }
    return flag;
}

hp = instance_create_layer(0,0,LAYER_ENEMY,obj_health);
hp.initialise(health_max_value, health_max_value);
hp.on_damage.set(function(){
    damage_flash.invoke(1,0.5);
    light.start_pulse_size_cycled(20, 40, 10, 0.5, 2);
    light.start_pulse_colour_cycled(c_white, 10, 0.5, 2);
    damage_particle.emit(20);
});
hp.on_tick_damage.set(function(){
    damage_flash.invoke(1,0.5);
    light.start_pulse_size_cycled(10, 80, 6, 0.5, 6);
    damage_particle.emit(20);
});
hp.on_death.set(function(){instance_destroy();});

alarm_set(movement_path_alarm_index, 1);

light = instance_create_layer(x,y,LAYER_LIGHTING, obj_light);
light.initialise(20,c_red, 360);

function update_light(){
    if(!instance_exists(light)){
        exit;
    }
    light.x = x;
    light.y = y;
}

element_status = instance_create_layer(0,0,LAYER_ENEMY, obj_element_status);
element_status.initialise(id);
element_status.on_status_set.set(function(){
    hp.start_tick_damage_loop(1, 3, 120);
});

function check_collisions(){
    if(place_meeting(x,y,obj_player) == true){
        obj_player.hp.damage(1);
    }
}
