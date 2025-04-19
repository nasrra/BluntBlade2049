/// @description Insert description here
// You can write your code in this editor
max_speed = 5;
current_speed = 0;
acceleration = 0.25;
deceleration = 0.50;
move_dir = point_direction(0, 0, 0, 0);
input_blocker = false;
damage_flash = new sh_damage_flash_controller(id, c_white);
element_status = undefined;


function move(){
    // calc move direction, normalising the vector so we dont go faster diagonally.
    // move_dir = point_direction(0,0,input_x, input_y);
    move_x = lengthdir_x(current_speed, move_dir);
    move_y = lengthdir_y(current_speed, move_dir);
    move_and_collide(move_x, move_y, obj_environment);
    update_ambient_light();
}

function block_input(){
    input_blocker = true;
}

function handle_input(){
    if(input_blocker == true){
        move_dir = 0;
        current_speed = 0;
        exit;
    }
    var input_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
    var input_y = keyboard_check(ord("S")) - keyboard_check(ord("W"));
    
    if(input_x == 0 && input_y == 0){
        current_speed = lerp(current_speed,0,deceleration);
    }
    else{
        current_speed = lerp(current_speed,max_speed,acceleration); 
        move_dir = point_direction(0, 0, input_x, input_y);
    }

    var parry_up    = keyboard_check_pressed(vk_up);
    var parry_down  = keyboard_check_pressed(vk_down);
    var parry_left  = keyboard_check_pressed(vk_left);
    var parry_right = keyboard_check_pressed(vk_right);

    if(parry_up == true){
        enable_parry_collision_box(PARRY_DIRECTION.UP);
    }
    else if(parry_down == true){
        enable_parry_collision_box(PARRY_DIRECTION.DOWN);
    }
    else if(parry_right == true){
        enable_parry_collision_box(PARRY_DIRECTION.RIGHT);
    }
    else if(parry_left == true){
        enable_parry_collision_box(PARRY_DIRECTION.LEFT);
    }


    // here for debug...
    var restart_room = keyboard_check_pressed(ord("R"));
    if(restart_room == true){
        room_restart();
    }
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
parry_part_system = part_system_create(prt_parry);
parry_particle = particle_get_info(prt_parry).emitters[0].parttype.ind;
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
        part_type_direction(parry_particle, 135, 225, 0, 0);
    }
    else if (parry_direction == PARRY_DIRECTION.RIGHT) {
        parry_cbox_x = x + parry_cbox_width;  // Position to the right of the player
        parry_cbox_y = y;
        part_type_direction(parry_particle, -45, 45, 0, 0);
    }
    else if (parry_direction == PARRY_DIRECTION.UP) {
        parry_cbox_x = x;
        parry_cbox_y = y - parry_cbox_height;  // Position above the player
        part_type_direction(parry_particle, 45, 135, 0, 0);
    }
    else if (parry_direction == PARRY_DIRECTION.DOWN) {
        parry_cbox_x = x;
        parry_cbox_y = y + parry_cbox_height;  // Position below the player
        part_type_direction(parry_particle, 225, 315, 0, 0);
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
            show_debug_message(instance.light.colour);
            if(instance.sender != id){
                instance.send_back_to_sender();
                instance.set_object_to_damage(obj_enemy);
                parried = true;
            }
        }
        if(parried == true){
            audiomanager_play_parry();
            obj_camera.shake_camera(44, 1, 12);
            part_particles_create(parry_part_system, x, y, parry_particle, 9);
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

hp = new HealthPoints(4,4);
i_frame_alarm_index = 2;
i_frame_time = 240;
hp.on_damage.set(function(){
    audiomanager_play_player_damaged();
    audiomanager_play_hit_glitch();
    enter_damaged_state();
    set_room_speed(5, 1);
    obj_ui_manager.update_healthbar(hp.current_value);
    obj_camera.shake_camera(75, 1, 12);
    damage_flash.invoke(6,2);
});
hp.on_death.set(function(){
    gamemanager_death_state();
    instance_destroy();
});
hp.on_heal.set(function(){
    obj_ui_manager.update_healthbar(hp.current_value);
})

function enter_damaged_state(){
    hp.now_invincible();
    obj_effect_layer_manager.turn_on_desaturate(0.1);
    obj_effect_layer_manager.turn_on_vignette(0.25);
    obj_effect_layer_manager.turn_on_rgb_noise(0.045);
    alarm_set(i_frame_alarm_index, i_frame_time);
}

function exit_damaged_state(){
    hp.not_invincible();
    audiomanager_stop_hit_glitch();
    obj_effect_layer_manager.turn_off_desaturate(0.15);
    obj_effect_layer_manager.turn_off_vignette(0.25);
    obj_effect_layer_manager.turn_off_rgb_noise(0.045);
}

function snap_to_position(_x, _y){
    x = _x;
    y = _y;
    obj_camera.snap_to_target();
}

ambient_light = undefined;
function create_ambient_light(){
    ambient_light = obj_lighting_manager.create_light_source(x,y,20,c_white);
}

function update_ambient_light(){
    ambient_light.x = x;
    ambient_light.y = y;
}

function _handle_element_status(){
    if(element_status == undefined){
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
    switch(element_status){
        case ElementType.FIRE:
            show_debug_message("PARRY TYPE: [FIRE]");
            parry_gun = GunParryElementFire(id);
            break;
        case ElementType.ICE:
            show_debug_message("PARRY TYPE: [ICE]");
            parry_gun = GunParryElementFire(id);
            break;
    }
    parry_gun.angle = angle;
    parry_gun.set_position(x,y);
    var bullets = parry_gun.shoot();
    for(var i = 0; i < array_length(bullets); i++){
        bullets[i].light.colour = c_white;
        bullets[i].object_to_damage = obj_enemy; 
    }
    element_status = undefined;
}