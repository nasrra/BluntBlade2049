/// @description Insert description here
// You can write your code in this editor

should_destroy = false;

if(roommanager_get_room_cleared(room) == true){
    instance_destroy();
    should_destroy = true;
    exit;
}

target = obj_player;
weapon = undefined;
movement = instance_create_layer(0,0,LAYER_ENEMY,obj_movement_pathed);
movement.target = target;


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
    var flag = false;
    if(collision_line(x, y, target.x, target.y, obj_dyn_environment, true, true) != noone){
        flag = true;
    }
    flag = collision_line(x, y, target.x, target.y, obj_environment, true, true) == noone? true : false;
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
