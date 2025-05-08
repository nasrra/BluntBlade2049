/// @description Insert description here
// You can write your code in this editor
sword = instance_create_layer(x,y,LAYER_PARTICLE, obj_sword);
sword_orbit = 32;
sword_angle = 0;
sword_keyboard_swivel_speed = 0.05;
sword.initialise(id);
can_parry = true;
sword.on_parry.set(function(){
    obj_camera.shake_camera(44, 1, 12);
    set_room_speed(9, 1);
});

sword.on_hit.set(function(){
    obj_camera.shake_camera(44, 1, 12);
    set_room_speed(9, 1);
});

sword.on_element_charges_exhausted.set(function(){
    light.stop_mod_colour();
    light.stop_mod_size();
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
}

element_status = instance_create_layer(0,0,LAYER_CHARACTER,obj_element_status);
element_status.initialise(id);
element_status.particle_offset_x = -sprite_width*0.5;
element_status.particle_offset_y = -sprite_height*0.5;
element_status.on_status_set.set(function(){
    hp.start_tick_damage_loop(1, 3, 120);
    // obj_fx_layer_manager.turn_on_heat_haze(0.25);
});
element_status.on_clear_status.set(function(){
    // obj_fx_layer_manager.turn_off_heat_haze(0.25);
    hp.stop_tick_damage_loop();
});
function update_element_status(){
    element_status.x = x-sprite_width*0.5;
    element_status.y = y-sprite_height*0.5;
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
    
    handle_sword_input();
    
    var input_x = input_get_move_x();
    var input_y = input_get_move_y();

    if(input_x == 0 && input_y == 0){
        movement.decelerate();
    }
    else{
        movement.accelerate();
        movement.set_move_direction_by_input(input_x, input_y)
    }

    if(input_get_parry() != 0 && can_parry == true){
        sword.parry();
    }
}

function handle_sword_input(){
    if(input_is_gamepad_connected() == true){
        var input_angle = point_direction(0,0,input_get_gamepad_aim_swivel_x(),input_get_gamepad_aim_swivel_y());
        sword_angle = input_angle > 0? input_angle : sword_angle;
    }
    else{
        var left = input_get_keyboard_aim_swivel_left();
        var right = input_get_keyboard_aim_swivel_right();
        var additive = 0;
        if(left >0 && right >0){
            sword_angle = sword_angle;    
        }
        else if(left >0 && right ==0){
            additive = point_direction(0,0,left,left) * sword_keyboard_swivel_speed;
        }
        else if(left ==0 && right >0){
            additive = point_direction(0,0,right,right) * -sword_keyboard_swivel_speed;
        }
        sword_angle += additive;
    }
    if(sword_angle >= 360){
        sword_angle -= 360;
    }
    if(sword_angle <= -360){
        sword_angle += 360;
    }
}

function update_sword(){
    // set positions.
    sword.x = x + lengthdir_x(sword_orbit, sword_angle);
    sword.y = y + lengthdir_y(sword_orbit, sword_angle);
    // set direction for light to point in.
    sword.image_angle = point_direction(x,y,sword.x,sword.y);
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

var global_health = player_get_global_health();
hp = instance_create_layer(0,0,LAYER_CHARACTER,obj_health);
hp.initialise(6,global_health!=undefined?global_health:6);
hp.on_damage.set(function(){
    audiomanager_play_player_damaged();
    hp.set_invincible_timed(60);
    obj_ui_manager.update_healthbar(hp.current_value);
    set_room_speed(5, 1);
    obj_camera.shake_camera(75, 1, 12);
    damage_flash.invoke(6,2);
    damage_particle.emit(20);
    player_set_global_health(hp.current_value);
    light.start_pulse_size_cycled(100, 200, 12, 0.1, 4);
    light.start_pulse_colour_cycled(c_red, 12, 0.1, 4);

});
hp.on_tick_damage.set(function(){
    audiomanager_play_player_damaged();
    obj_ui_manager.update_healthbar(hp.current_value);
    set_room_speed(5, 1);
    obj_camera.shake_camera(75, 1, 12);
    damage_flash.invoke(6,2);
    damage_particle.emit(20);
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

    player_set_global_health(hp.current_value);
});
hp.on_death.set(function(){
    gamemanager_death_state();
    player_set_global_health(hp.max_value);
    instance_destroy();
});
hp.on_heal.set(function(){
    obj_ui_manager.update_healthbar(hp.current_value);
    var heal_particle = instance_create_layer(x,y,LAYER_CHARACTER, obj_particle_system);
    heal_particle.initialise(part_type_heal(),0,0);
    heal_particle.emit_one_shot(30,60);
    light.start_pulse_size_cycled(100, 200, 12, 0.25, 3);
    light.start_pulse_colour_cycled(c_green, 24, 0.33, 2);
    player_set_global_health(hp.current_value);
    element_status.clear_status();
})
hp.on_invincible.set(function(){
    // enter damaged state.
    // audiomanager_play_hit_glitch();
    obj_fx_layer_manager.turn_on_desaturate(0.1);
    obj_fx_layer_manager.turn_on_vignette(0.25);
    obj_fx_layer_manager.turn_on_rgb_noise(0.045);
    // can_parry = false;
});
hp.on_vincible.set(function(){
    // exit damaged state.
    audiomanager_stop_hit_glitch();
    obj_fx_layer_manager.turn_off_desaturate(0.15);
    obj_fx_layer_manager.turn_off_vignette(0.25);
    obj_fx_layer_manager.turn_off_rgb_noise(0.045);
    light.stop_mod_colour();
    light.stop_mod_size();
    can_parry = true;
});

function snap_to_position(_x, _y){
    x = _x;
    y = _y;
    obj_camera.snap_to_target();
}

light = instance_create_layer(x+(sprite_width/2),y+(sprite_height/2),LAYER_LIGHTING, obj_light);
light.initialise(100,c_white, 360, 0.00001);

function update_light(){
    light.x = x;
    light.y = y;
}

function stun(){
    movement.mod_speed_timed(0,30);
}

function set_power_up_state(_element_type){
    sword.element_type = _element_type;
    switch(_element_type){
        case ElementType.FIRE:
            light.start_pulse_colour(c_fire_light, 6, 0.5);            
        break;
        case ElementType.ELECTRIC:
            light.start_pulse_colour(c_electric, 6, 0.5);            
        break;
    }
}