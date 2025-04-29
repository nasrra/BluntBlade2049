// generic.
max_speed       = undefined;
current_speed   = 0;
acceleration    = undefined;
deceleration    = undefined;
move_dir        = point_direction(0, 0, 0, 0);
entity_id       = undefined;

// mod max speed.
mod_max_speed_initial       = undefined;
mod_max_speed_frame_time    = undefined;
mod_max_speed_current_frame = 0;
mod_max_speed_alarm_index   = 0;

// abstract function.
move = undefined;

function initialise(_entity_id, _max_speed, _acceleration, _decleration){
    entity_id       = _entity_id;
    max_speed       = _max_speed;
    acceleration    = _acceleration;
    deceleration    = _decleration;
}

function mod_speed_timed(_speed, _time_in_frames){
    mod_max_speed_initial = max_speed;
    max_speed = _speed;
    mod_max_speed_frame_time = _time_in_frames; 
    alarm_set(mod_max_speed_alarm_index,1);
}

function reset_mod_max_speed(){
    mod_max_speed_initial       = undefined;
    mod_max_speed_frame_time    = undefined;
    mod_max_speed_current_frame = 0;
}

function _mod_speed_loop(){
    mod_max_speed_current_frame++;
    if(mod_max_speed_current_frame >= mod_max_speed_frame_time){
        max_speed = mod_max_speed_initial;
        reset_mod_max_speed();
        exit;
    }
    alarm_set(mod_max_speed_alarm_index,1);
}

function accelerate(){
    current_speed = lerp(current_speed,max_speed,acceleration); 
    // show_debug_message(current_speed);
}

function decelerate(){
    current_speed = lerp(current_speed,0,deceleration); 
    // show_debug_message(current_speed);
}

function set_move_direction_by_input(_input_x, _input_y){
    move_dir = point_direction(0, 0, _input_x, _input_y);
    // show_debug_message(move_dir);
}