/// @description Insert description here
// You can write your code in this editor
gui_w = display_get_gui_width();
gui_h = display_get_gui_height();



// healthbar draw calls.

healthbar_heart_amount = 0;
healthbar_start_x = 10;
healthbar_start_y = 10;
healthbar_heart_spacing = 20;
healthbar_heart_scale = 4;

function update_healthbar(_amount){
    healthbar_heart_amount = _amount;
}

function draw_healthbar_hearts(){
    for(var i = 0; i < healthbar_heart_amount; i++){
        var x_offset = (healthbar_start_x * healthbar_heart_scale) + healthbar_heart_spacing * i * healthbar_heart_scale;
        var y_offset = healthbar_start_y * healthbar_heart_scale;
        draw_sprite_ext(
            spr_healthbar_heart,
            0, 
            x_offset, 
            y_offset, 
            healthbar_heart_scale, 
            healthbar_heart_scale,
            image_angle,
            image_blend,
            image_alpha
        );
    }
}





// death draw calls.

function draw_death_background(){
    draw_set_alpha(0.75);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    draw_set_color(c_white);
}

function draw_death_text(){
    var text = "[DEATH]";
    var size = 10;

    draw_set_font(font_1);
    draw_set_color(c_white);

    var text_w = string_width(text) * size;
    var text_h = string_height(text) * size;

    draw_text_transformed(
        (gui_w / 2) - (text_w * 0.5),
        (gui_h / 2) - (gui_h*0.25),
        text,
        size,
        size,
        0
    );


    text = "|Press [ANY KEY] to Restart|";
    size = 2.5;
    text_w = string_width(text) * size;
    text_h = string_height(text) * size;

    draw_text_transformed(
        (gui_w / 2) - (text_w * 0.5),
        (gui_h / 2) + (gui_h*0.05),
        text,
        size,
        size,
        0
    );
}

function death_input(){
    var input = keyboard_check_pressed(vk_anykey);
    if(input == true){
        room_restart();
        gamemanager_gameplay_state();
    }
}





// room transition draw calls.

room_transition_desired_offset_x   = undefined;
room_transition_desired_offset_y   = undefined;
room_transition_current_offset_x   = undefined;
room_transition_current_offset_y   = undefined;
room_transition_alarm_index        = 0;
room_transition_speed              = 60;
room_transition_current_speed      = 0;
room_transtion_speed_aspect_ratio_factor = 1.78; // keep a consitent speed when going left or right.
room_transition_active             = false;

enum RoomTransitionMovement{
    LEFT_TO_RIGHT,
    RIGHT_TO_LEFT,
    TOP_TO_BOT,
    BOT_TO_TOP,
}

enum RoomTransitionSetup{
    EXIT,
    ENTER,
}

function draw_room_transition(){
    draw_set_alpha(1);
    draw_set_color(c_black);
    draw_rectangle(
        room_transition_current_offset_x, 
        room_transition_current_offset_y, 
        room_transition_current_offset_x + gui_w, 
        room_transition_current_offset_y + gui_h, 
        false
    );
    draw_set_color(c_white);   
}

// on room_start event.
function check_room_transition(){
    show_debug_message(global.current_room_transition_movement);
    var set_up = global.current_room_transition_setup == RoomTransitionSetup.EXIT? RoomTransitionSetup.ENTER : RoomTransitionSetup.EXIT;
    switch(global.current_room_transition_movement){
        case RoomTransitionMovement.LEFT_TO_RIGHT:
            start_room_transition(RoomTransitionMovement.RIGHT_TO_LEFT, set_up);
            break;
        case RoomTransitionMovement.RIGHT_TO_LEFT:
            start_room_transition(RoomTransitionMovement.LEFT_TO_RIGHT, set_up);
            break;
        case RoomTransitionMovement.TOP_TO_BOT:
            start_room_transition(RoomTransitionMovement.BOT_TO_TOP, set_up);
            break;
        case RoomTransitionMovement.BOT_TO_TOP:
            start_room_transition(RoomTransitionMovement.TOP_TO_BOT, set_up);
            break;
    } 
}

function start_room_transition(_room_transition_movement, _room_transition_setup){
    room_transition_active = true;
    if(_room_transition_setup == RoomTransitionSetup.EXIT){
        set_exit_room_transition(_room_transition_movement);
    }
    if(_room_transition_setup == RoomTransitionSetup.ENTER){
        set_enter_room_transition(_room_transition_movement);
    }
    global.current_room_transition_movement = _room_transition_movement;
    global.current_room_transition_setup = _room_transition_setup;
    show_debug_message("start room transition!");
    alarm_set(room_transition_alarm_index, 1);
}

function set_exit_room_transition(_room_transition_movement){
    switch(_room_transition_movement){
        case RoomTransitionMovement.LEFT_TO_RIGHT:
            room_transition_current_offset_x = -gui_w;
            room_transition_current_offset_y = 0;
            room_transition_desired_offset_x = 0;
            room_transition_desired_offset_y = 0;
            room_transition_current_speed = room_transition_speed * room_transtion_speed_aspect_ratio_factor;
            break;
        case RoomTransitionMovement.RIGHT_TO_LEFT:
            room_transition_current_offset_x = gui_w;
            room_transition_current_offset_y = 0;
            room_transition_desired_offset_x = 0;
            room_transition_desired_offset_y = 0;
            room_transition_current_speed = room_transition_speed * room_transtion_speed_aspect_ratio_factor;
            break;
        case RoomTransitionMovement.BOT_TO_TOP:
            room_transition_current_offset_x = 0;
            room_transition_current_offset_y = gui_h;
            room_transition_desired_offset_x = 0;
            room_transition_desired_offset_y = 0;
            room_transition_current_speed = room_transition_speed;
            break;
        case RoomTransitionMovement.TOP_TO_BOT:
            room_transition_current_offset_x = 0;
            room_transition_current_offset_y = -gui_h;
            room_transition_desired_offset_x = 0;
            room_transition_desired_offset_y = 0;
            room_transition_current_speed = room_transition_speed;
            break;
    }
}

function set_enter_room_transition(_room_transition_movement){
    switch(_room_transition_movement){
        case RoomTransitionMovement.LEFT_TO_RIGHT:
            room_transition_current_offset_x = 0;
            room_transition_current_offset_y = 0;
            room_transition_desired_offset_x = -gui_w;
            room_transition_desired_offset_y = 0;
            room_transition_current_speed = room_transition_speed * room_transtion_speed_aspect_ratio_factor;
            break;
        case RoomTransitionMovement.RIGHT_TO_LEFT:
            room_transition_current_offset_x = 0;
            room_transition_current_offset_y = 0;
            room_transition_desired_offset_x = gui_w;
            room_transition_desired_offset_y = 0;
            room_transition_current_speed = room_transition_speed * room_transtion_speed_aspect_ratio_factor;
            break;
        case RoomTransitionMovement.BOT_TO_TOP:
            room_transition_current_offset_x = 0;
            room_transition_current_offset_y = 0;
            room_transition_desired_offset_x = 0;
            room_transition_desired_offset_y = gui_h;
            room_transition_current_speed = room_transition_speed;
            break;
        case RoomTransitionMovement.TOP_TO_BOT:
            room_transition_current_offset_x = 0;
            room_transition_current_offset_y = 0;
            room_transition_desired_offset_x = 0;
            room_transition_desired_offset_y = -gui_h;
            room_transition_current_speed = room_transition_speed;
            break;
    }
}


function update_room_transition_position(){
    var dir = point_direction(  
        room_transition_current_offset_x,
        room_transition_current_offset_y,
        room_transition_desired_offset_x,
        room_transition_desired_offset_y
    );
    
    var dist = point_distance(
        room_transition_current_offset_x,
        room_transition_current_offset_y,
        room_transition_desired_offset_x,
        room_transition_desired_offset_y
    );

    var movement = min(room_transition_current_speed, dist);

    room_transition_current_offset_x+=lengthdir_x(movement, dir);
    room_transition_current_offset_y+=lengthdir_y(movement, dir);
    show_debug_message(room_transition_current_offset_x);
    show_debug_message(room_transition_current_offset_y);
    if(dist <= 1){
        show_debug_message("room transition completed!");
        // if we are entering a room, dont transition;
        if(global.current_room_transition_setup == RoomTransitionSetup.ENTER){
            exit;
        }
        roommanager_goto_room();
        room_transition_active = false;
        exit;
    }
    else{
        alarm_set(room_transition_alarm_index, 1);
    }
}
