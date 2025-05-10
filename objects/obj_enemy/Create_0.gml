/// @description Insert description here
// You can write your code in this editor
sprite_left     = undefined;
sprite_right    = undefined;
sprite_down     = undefined;
sprite_up       = undefined;

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
    show_debug_message(id.direction);

    if(direction >= 225 && direction <= 330){
        if(sprite_down != undefined){
            sprite_index = sprite_down;
        }
    }
    else if(direction >= 45 && direction <= 135){
        if(sprite_up != undefined){
            sprite_index = sprite_up;
        }
    }
    else if(direction >= 135 && direction <= 225){
        if(sprite_left != undefined){
            sprite_index = sprite_left;
        }
    }
    else if(direction >= 330 || direction <= 45){
        if(sprite_right != undefined){
            sprite_index = sprite_right;
        }
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
    var flag = true;
    if(collision_line(x, y, target.x, target.y, obj_dyn_environment, true, true) != noone){
        flag = true;
    }
    var wall_list = ds_list_create();
    collision_line_list(x, y, target.x, target.y, obj_environment, true, true, wall_list, true);
    for(var i = 0; i < ds_list_size(wall_list); i++){
        var wall = wall_list[| i];
        if(wall.shoot_through == false){
            flag = false;
            break;
        }
        else{
            flag = true;
        }
    }
    ds_list_destroy(wall_list);
    return flag;
}

hp = instance_create_layer(0,0,LAYER_ENEMY,obj_health);
hp.initialise(health_max_value, health_max_value);
hp.on_damage.set(function(){
    damage_flash.invoke(1,0.5);
    light.start_pulse_size_cycled(200, 440, 10, 0.5, 3);
    light.start_pulse_colour_cycled(c_white, 10, 0.5, 3);
    damage_particle.emit(20);
    audiomanager_play_player_damaged();
});
hp.on_tick_damage.set(function(){
    damage_flash.invoke(1,0.5);
    light.start_pulse_size_cycled(100, 200, 12, 0.25, 3);
    switch(element_status.status){
        case ElementType.FIRE:
            light.start_pulse_colour_cycled(c_fire_light, 24, 0.33, 2);
            break;
        case ElementType.ELECTRIC:
            light.start_pulse_colour_cycled(c_electric, 24, 0.33, 2);
            stun();
            break;
    }
    audiomanager_play_player_damaged();
    damage_particle.emit(20);
});
hp.on_death.set(function(){instance_destroy();});


light = instance_create_layer(x,y,LAYER_LIGHTING, obj_light);
light.initialise(200,c_white, 360, 0.5);

function update_light(){
    if(!instance_exists(light)){
        exit;
    }
    light.x = x;
    light.y = y;
}

element_status = instance_create_layer(0,0,LAYER_ENEMY, obj_element_status);
element_status.initialise(id);
element_status.particle_offset_x = -sprite_width*0.5;
element_status.particle_offset_y = -sprite_height*0.5;
element_status.on_status_set.set(function(){
    hp.start_tick_damage_loop(1, 1, 120);
});

function check_collisions(){
    if(place_meeting(x,y,obj_player) == true){
        obj_player.hp.damage(1);
    }
}


function stun(){
    movement.mod_speed_timed(0,30);
}