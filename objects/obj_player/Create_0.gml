/// @description Insert description here
// You can write your code in this editor
shield = instance_create_layer(x,y,LAYER_CHARACTER, obj_shield);
shield_orbit = 32;
shield_angle = 0;
shield_keyboard_swivel_speed = 0.05;
shield.on_parry.set(function(){
    set_room_speed(9, 1);
});

movement = instance_create_layer(0,0,LAYER_CHARACTER, obj_movement_input);
movement.initialise(id, 4.5, 0.5, 0.75);
input_blocker = false;

damage_flash = new sh_damage_flash_controller(id, c_white);
damage_particle = instance_create_layer(x,y,LAYER_CHARACTER, obj_particle_system);
damage_particle.initialise(part_type_entity_damaged(), 0, 0);
function update_particles(){
    damage_particle.x = x;
    damage_particle.y = y;
    parry_particle.x = x;
    parry_particle.y = y;
}

element_status = instance_create_layer(0,0,LAYER_CHARACTER,obj_element_status);
element_status.initialise(id);
element_status.particle_offset_x = -sprite_width*0.5;
element_status.particle_offset_y = -sprite_height*0.5;
element_status.on_status_set.set(function(){
    hp.start_tick_damage_loop(1, 3, 120);
    obj_fx_layer_manager.turn_on_heat_haze(0.25);
});
element_status.on_clear_status.set(function(){
    obj_fx_layer_manager.turn_off_heat_haze(0.25);
});
function update_element_status(){
    element_status.x = x;
    element_status.y = y;
}

function block_input(){
    input_blocker = true;
}

function handle_input(){
    if(input_blocker == true){
        movement.move_dir = 0;
        movement.current_speed = 0;
        exit;
    }
    
    handle_shield_input();
    
    var input_x = input_get_move_x();
    var input_y = input_get_move_y();

    if(input_x == 0 && input_y == 0){
        movement.decelerate();
    }
    else{
        movement.accelerate();
        movement.set_move_direction_by_input(input_x, input_y)
    }

    if(input_get_parry() != 0){
        shield.parry();
    }

    // var parry_up    = keyboard_check_pressed(vk_up);
    // var parry_down  = keyboard_check_pressed(vk_down);
    // var parry_left  = keyboard_check_pressed(vk_left);
    // var parry_right = keyboard_check_pressed(vk_right);

    // if(parry_up == true){
    //     enable_parry_collision_box(PARRY_DIRECTION.UP);
    // }
    // else if(parry_down == true){
    //     enable_parry_collision_box(PARRY_DIRECTION.DOWN);
    // }
    // else if(parry_right == true){
    //     enable_parry_collision_box(PARRY_DIRECTION.RIGHT);
    // }
    // else if(parry_left == true){
    //     enable_parry_collision_box(PARRY_DIRECTION.LEFT);
    // }
}

function handle_shield_input(){
    if(input_is_gamepad_connected() == true){
        var input_angle = point_direction(0,0,input_get_gamepad_shield_swivel_x(),input_get_gamepad_shield_swivel_y());
        shield_angle = input_angle > 0? input_angle : shield_angle;
    }
    else{
        var left = input_get_keyboard_shield_swivel_left();
        var right = input_get_keyboard_shield_swivel_right();
        var additive = 0;
        if(left >0 && right >0){
            shield_angle = shield_angle;    
        }
        else if(left >0 && right ==0){
            additive = point_direction(0,0,left,left) * shield_keyboard_swivel_speed;
        }
        else if(left ==0 && right >0){
            additive = point_direction(0,0,right,right) * -shield_keyboard_swivel_speed;
        }
        shield_angle += additive;
    }
    if(shield_angle >= 360){
        shield_angle -= 360;
    }
    if(shield_angle <= -360){
        shield_angle += 360;
    }
}

function update_shield(){
    // set positions.
    shield.x = x + lengthdir_x(shield_orbit, shield_angle);
    shield.y = y + lengthdir_y(shield_orbit, shield_angle);
    // set direction for light to point in.
    shield.image_angle = point_direction(x,y,shield.x,shield.y);
}

parry_cbox_width = 30;
parry_cbox_height = 30;
parry_cbox_x = 0;
parry_cbox_y = 0;
parry_cbox_active = false;
parry_cbox_timer = 0;
parry_cbox_alarm_index = 0;
parry_cbox_hit = false;
parry_direction = undefined;
parry_particle = instance_create_layer(x,y,id.layer, obj_particle_system);
parry_particle.initialise(part_type_parry(),sprite_width*0.5,sprite_height*0.5,id);
function enable_parry_collision_box(_parry_direction){
    if(parry_cbox_active == false){
        parry_direction = _parry_direction;
        _handle_element_status();
        _handle_cbox_position();
        parry_cbox_timer = 20;
        parry_cbox_active = true;
        // show_debug_message("parry!");
        alarm_set(parry_cbox_alarm_index, 1);
    }
}

function _handle_cbox_position(){
    // Adjust the position of the collision box based on the parry direction
    if (parry_direction == PARRY_DIRECTION.LEFT) {
        parry_cbox_x = x - parry_cbox_width;  // Position to the left of the player
        parry_cbox_y = y;
        parry_particle.set_emission_angle(135, 225);
    }
    else if (parry_direction == PARRY_DIRECTION.RIGHT) {
        parry_cbox_x = x + parry_cbox_width;  // Position to the right of the player
        parry_cbox_y = y;
        parry_particle.set_emission_angle(-45, 45);
    }
    else if (parry_direction == PARRY_DIRECTION.UP) {
        parry_cbox_x = x;
        parry_cbox_y = y - parry_cbox_height;  // Position above the player
        parry_particle.set_emission_angle(45, 135);
    }
    else if (parry_direction == PARRY_DIRECTION.DOWN) {
        parry_cbox_x = x;
        parry_cbox_y = y + parry_cbox_height;  // Position below the player
        parry_particle.set_emission_angle(225, 315);
    }
}

function _check_cbox_collision(){
    var left = parry_cbox_x - parry_cbox_width / 2;
    var top = parry_cbox_y - parry_cbox_height / 2;
    var right = parry_cbox_x + parry_cbox_width / 2;
    var bottom = parry_cbox_y + parry_cbox_height / 2;
    var collisions = ds_list_create();
    var parried = false;
    collision_rectangle_list(left, top, right, bottom, obj_bullet, true, true, collisions, false);

    // if we successfully parry a bullet.
    if (ds_list_size(collisions) > 0) {
        for(var i = 0; i < ds_list_size(collisions); i++){
            var instance = ds_list_find_value(collisions, i);
            if(instance.sender != id){
                instance.send_back_to_sender();
                instance.set_object_to_damage(obj_enemy);
                parried = true;
            }
        }
        if(parried == true){
            audiomanager_play_parry();
            obj_camera.shake_camera(44, 1, 12);
            parry_particle.emit(15);
            set_room_speed(9, 1);
            parry_cbox_hit = true;
        }
    }
    ds_list_destroy(collisions);
}

function _check_parry_collision_box(){
    if(parry_cbox_timer > 0){
        // check collision and draw collision box.
        parry_cbox_timer -= 1;
        _handle_cbox_position();
        _check_cbox_collision();
        if(parry_cbox_hit == true){
            _parry_cbox_finish();
        }
        else{
            alarm_set(parry_cbox_alarm_index, 1);
        }
    }
    else{
        _parry_cbox_finish();
    }
}

function _parry_cbox_finish(){
    parry_cbox_active = false;
    parry_cbox_hit = false;
    // show_debug_message("finished parry!");        
}

enum PARRY_DIRECTION{
    LEFT,
    RIGHT,
    UP,
    DOWN
}

room_speed_timer = 0;
room_speed_alarm_index = 1;
room_speed_active = false;
room_modified_speed = 1;
function set_room_speed(_speed,_timer){
    room_speed_timer    = _timer;
    room_modified_speed = _speed;
    room_speed_modified = true;
    alarm_set(room_speed_alarm_index, 1);
}

function check_room_speed_timer(){
    if(room_speed_modified == true){
        room_speed = room_modified_speed;
        room_speed_modified = false;
        alarm_set(room_speed_alarm_index, room_speed_timer);
    }
    else{
        room_speed = 60;
    }
}

hp = instance_create_layer(0,0,LAYER_CHARACTER,obj_health);
hp.initialise(4,4);
hp.on_damage.set(function(){
    hp.set_invincible_timed(240);
    obj_ui_manager.update_healthbar(hp.current_value);
    set_room_speed(5, 1);
    obj_camera.shake_camera(75, 1, 12);
    damage_flash.invoke(6,2);
    damage_particle.emit(20);
});
hp.on_tick_damage.set(function(){
    audiomanager_play_player_damaged();
    obj_ui_manager.update_healthbar(hp.current_value);
    set_room_speed(5, 1);
    obj_camera.shake_camera(75, 1, 12);
    damage_flash.invoke(6,2);
    damage_particle.emit(20);
});
hp.on_death.set(function(){
    gamemanager_death_state();
    instance_destroy();
});
hp.on_heal.set(function(){
    obj_ui_manager.update_healthbar(hp.current_value);
    var heal_particle = instance_create_layer(x,y,LAYER_CHARACTER, obj_particle_system);
    heal_particle.initialise(part_type_heal(),0,0);
    heal_particle.emit_one_shot(30,60);
    light.start_pulse_size_cycled(20, 80, 12, 0.25, 3);
    light.start_pulse_colour_cycled(c_green, 24, 0.33, 2);
})
hp.on_invincible.set(function(){
    // enter damaged state.
    audiomanager_play_player_damaged();
    audiomanager_play_hit_glitch();
    obj_fx_layer_manager.turn_on_desaturate(0.1);
    obj_fx_layer_manager.turn_on_vignette(0.25);
    obj_fx_layer_manager.turn_on_rgb_noise(0.045);
});
hp.on_vincible.set(function(){
    // exit damaged state.
    audiomanager_stop_hit_glitch();
    obj_fx_layer_manager.turn_off_desaturate(0.15);
    obj_fx_layer_manager.turn_off_vignette(0.25);
    obj_fx_layer_manager.turn_off_rgb_noise(0.045);
});

function snap_to_position(_x, _y){
    x = _x;
    y = _y;
    obj_camera.snap_to_target();
}

light = instance_create_layer(x+(sprite_width/2),y+(sprite_height/2),LAYER_LIGHTING, obj_light);
light.initialise(20,c_white, 360);

function update_light(){
    light.x = x;
    light.y = y;
}

function _handle_element_status(){
    if(element_status.status == undefined){
        exit;
    }
    
    var angle = undefined;
    var parry_gun = undefined;

    switch(parry_direction){
        case PARRY_DIRECTION.UP:
            angle = 90;
            break;
        case PARRY_DIRECTION.DOWN:
            angle = 270;
            break;
        case PARRY_DIRECTION.LEFT:
            angle = 180;
            break;
        case PARRY_DIRECTION.RIGHT:
            angle = 0;
            break;
    }
    switch(element_status.status){
        case ElementType.FIRE:
            show_debug_message("PARRY TYPE: [FIRE]");
            parry_gun = GunElementFire(id);
            break;
        case ElementType.ELECTRIC:
            show_debug_message("PARRY TYPE: [ELECTRIC]");
            parry_gun = GunElementElectric(id);
            break;
    }
    parry_gun.angle = angle;
    parry_gun.set_position(x,y);
    var bullets = parry_gun.shoot();
    for(var i = 0; i < array_length(bullets); i++){
        bullets[i].light.colour = c_white;
        bullets[i].object_to_damage = obj_enemy; 
    }
    element_status.clear_status();
    hp.stop_tick_damage_loop();
}