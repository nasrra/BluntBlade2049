/// @description Insert description here
// You can write your code in this editor

mod_size_min           = undefined;
mod_size_max           = undefined;
mod_size_initial_size  = undefined;
mod_size_target_size   = undefined;
mod_size_infinite      = undefined;
mod_size_max_frame     = undefined;
mod_size_frame_change  = undefined;
mod_size_lerp_speed    = undefined;
mod_size_decrease      = undefined;
mod_size_alarm_index   = undefined;
mod_size_current_cycle = undefined;
mod_size_max_cycle     = 0;
mod_size_current_frame = 0;

mod_colour_initial_colour           = undefined;
mod_colour_target_colour            = undefined;
mod_colour_lerp_speed               = undefined;
mod_colour_infinite                 = undefined;
mod_colour_max_frame                = undefined;
mod_colour_frame_change             = undefined;
mod_colour_lerp_initial             = undefined;
mod_colour_alarm_index              = undefined;
mod_colour_max_cycle                = 0;
mod_colour_current_frame            = 0;
mod_colour_current_cycle            = 0;
// start at the initial colour





// GENERIC:
function initialise(_size, _colour, _fov){
    size                        = _size;
    mod_size_initial_size       = _size;
    colour                      = _colour;
    mod_colour_initial_colour   = _colour;
    fov                         = _fov;
}

function timed_destroy(_time_in_frames){
    alarm_set(11,_time_in_frames);
}

function _start_mod_size_alarm(_index){
    // stop the alarm that is currently going.
    if(mod_size_alarm_index != undefined){
        alarm_set(mod_size_alarm_index,0);
    }
    // set the prepare for the new one.
    mod_size_alarm_index = _index;
    alarm_set(mod_size_alarm_index, 1);
}

function stop_mod_size(){
    alarm_set(mod_size_alarm_index, 0);
    reset_mod_size();
}

function reset_mod_size(){
    mod_size_min           = undefined;
    mod_size_max           = undefined;
    mod_size_target_size   = undefined;
    mod_size_infinite      = undefined;
    mod_size_max_frame     = undefined;
    mod_size_frame_change  = undefined;
    mod_size_lerp_speed    = undefined;
    mod_size_decrease      = undefined;
    mod_size_alarm_index   = undefined;
    mod_size_current_cycle = undefined;
    mod_size_max_cycle     = 0;
    mod_size_current_frame = 0;
	size				   = mod_size_initial_size;
}

function reset_mod_colour(){
    mod_colour_target_colour            = undefined;
    mod_colour_lerp_speed               = undefined;
    mod_colour_infinite                 = undefined;
    mod_colour_max_frame                = undefined;
    mod_colour_frame_change             = undefined;
    mod_colour_lerp_initial             = undefined;
    mod_colour_alarm_index              = undefined;
    mod_colour_max_cycle                = 0;
    mod_colour_current_frame            = 0;
    mod_colour_current_cycle            = 0;
    colour                              = mod_colour_initial_colour;
}

function _start_mod_colour_alarm(_index){
    // stop the alarm that is currently going.
    if(mod_colour_alarm_index != undefined){
        alarm_set(mod_colour_alarm_index,0);
    }
    // set the prepare for the new one.
    mod_colour_alarm_index = _index;
    alarm_set(mod_colour_alarm_index, 1);
}

function stop_mod_colour(){
    alarm_set(mod_colour_alarm_index, 0);
    reset_mod_colour();
}





// RANDOM SIZE:

function start_random_size(_size_min, _size_max, _size_frame_change, _size_lerp_speed){
    mod_size_min           = _size_min;
    mod_size_max           = _size_max;
    mod_size_frame_change  = _size_frame_change;
    mod_size_lerp_speed    = _size_lerp_speed;
    mod_size_target_size = random_range(_size_min, _size_max);
    mod_size_infinite      = true;
    _start_mod_size_alarm(0);
}

function start_random_size_timed(_size_min, _size_max, _size_frame_change, _size_lerp_speed, _size_max_frame){
    mod_size_min           = _size_min;
    mod_size_max           = _size_max;
    mod_size_frame_change  = _size_frame_change;
    mod_size_lerp_speed    = _size_lerp_speed;
    mod_size_max_frame     = _size_max_frame;
    mod_size_target_size   = random_range(_size_min, _size_max);
    mod_size_infinite      = false;
    _start_mod_size_alarm(0);
}

function _alarm_random_size_loop(){
    if(mod_size_infinite == false && mod_size_current_frame == mod_size_max_frame){
        stop_mod_size();
        exit;
    }
    size = lerp(size, mod_size_target_size, mod_size_lerp_speed);

    mod_size_current_frame++;

    if(mod_size_current_frame = mod_size_frame_change){
        mod_size_current_frame = 0;
        mod_size_target_size = random_range(mod_size_min, mod_size_max);
    }
    
    alarm_set(mod_size_alarm_index, 1);
}





// PULSE RANDOM SIZE:

function start_pulse_random_size(_initial_size, _size_min, _size_max, _size_frame_change, _size_lerp_speed){
    mod_size_initial_size  = _initial_size;
    mod_size_min           = _size_min;
    mod_size_max           = _size_max;
    mod_size_frame_change  = _size_frame_change;
    mod_size_lerp_speed    = _size_lerp_speed;
    mod_size_target_size = random_range(_size_min, _size_max);
    mod_size_infinite      = true;
    _start_mod_size_alarm(1);
}

function start_pulse_random_size_timed(_initial_size, _size_min, _size_max, _size_frame_change, _size_lerp_speed, _size_max_frame){
    mod_size_initial_size  = _initial_size;
    mod_size_min           = _size_min;
    mod_size_max           = _size_max;
    mod_size_frame_change  = _size_frame_change;
    mod_size_lerp_speed    = _size_lerp_speed;
    mod_size_max_frame     = _size_max_frame;
    mod_size_target_size   = random_range(_size_min, _size_max);
    mod_size_infinite      = false;
    _start_mod_size_alarm(1);
}

function _alarm_pulse_random_size_loop(){
    if(mod_size_infinite == false && mod_size_current_frame == mod_size_max_frame){
        stop_mod_size();
        exit;
    }
    size = lerp(size, mod_size_target_size, mod_size_lerp_speed);

    mod_size_current_frame++;

    if(mod_size_current_frame = mod_size_frame_change){
        mod_size_current_frame = 0;
        if(mod_size_decrease == true){
            mod_size_target_size = random_range(mod_size_min, mod_size_initial_size);
        }
        else{
            mod_size_target_size = random_range(mod_size_initial_size, mod_size_max);
        }
        mod_size_decrease = !mod_size_decrease;
    }
    
    alarm_set(mod_size_alarm_index, 1);
}





// PULSE SIZE:

function start_pulse_size(_size_min, _size_max, _size_frame_change, _size_lerp_speed){
    mod_size_min           = _size_min;
    mod_size_max           = _size_max;
    mod_size_frame_change  = _size_frame_change;
    mod_size_lerp_speed    = _size_lerp_speed;
    mod_size_target_size   = _size_max;
    mod_size_infinite      = true;
    // start on the lowest size.
    mod_size_decrease      = false;
    size                   = _size_min;
    _start_mod_size_alarm(2);
}

function start_pulse_size_timed(_size_min, _size_max, _size_frame_change, _size_lerp_speed, _size_max_frame){
    mod_size_min           = _size_min;
    mod_size_max           = _size_max;
    mod_size_frame_change  = _size_frame_change;
    mod_size_lerp_speed    = _size_lerp_speed;
    mod_size_target_size   = _size_max;
    mod_size_infinite      = true;
    mod_size_max_frame     = _size_max_frame;
    // start on the lowest size.
    mod_size_decrease      = false;
    size                   = _size_min;
    _start_mod_size_alarm(2);
}

function start_pulse_size_cycled(_size_min, _size_max, _size_frame_change, _size_lerp_speed, _size_max_cycle){
    mod_size_min           = _size_min;
    mod_size_max           = _size_max;
    mod_size_frame_change  = _size_frame_change;
    mod_size_lerp_speed    = _size_lerp_speed;
    mod_size_target_size   = _size_max;
    mod_size_infinite      = true;
    mod_size_current_cycle = 0;
    mod_size_max_cycle     = _size_max_cycle;
    // start on the lowest size.
    mod_size_decrease      = false;
    size                   = _size_min;
    _start_mod_size_alarm(2);
}

function _alarm_pulse_size_loop(){
    if(mod_size_infinite == false && mod_size_current_frame == mod_size_max_frame || mod_size_current_cycle == mod_size_max_cycle){
        stop_mod_size();
        exit;
    }
    size = lerp(size, mod_size_target_size, mod_size_lerp_speed);

    mod_size_current_frame++;

    if(mod_size_current_frame = mod_size_frame_change){
        mod_size_current_frame = 0;
        if(mod_size_current_cycle != undefined){
            mod_size_current_cycle++;
        }
        if(mod_size_decrease == true){
            mod_size_target_size = mod_size_min;
        }
        else{
            mod_size_target_size = mod_size_max;
        }
        mod_size_decrease = !mod_size_decrease;
    }
    
    alarm_set(mod_size_alarm_index, 1);
}





// PULSE COLOUR:
function start_pulse_colour(_colour_target, _colour_frame_change, _colour_lerp_speed){
    mod_colour_target_colour            = _colour_target;
    mod_colour_frame_change             = _colour_frame_change;
    mod_colour_lerp_speed               = _colour_lerp_speed;
    mod_colour_infinite                 = true;
    // start at the target colour
    mod_colour_lerp_initial             = false;
    colour                              = mod_colour_initial_colour;
    _start_mod_colour_alarm(3);
}

function start_pulse_colour_timed(_colour_target, _colour_frame_change, _colour_lerp_speed, _max_frame){
    mod_colour_target_colour            = _colour_target;
    mod_colour_frame_change             = _colour_frame_change;
    mod_colour_lerp_speed               = _colour_lerp_speed;
    mod_colour_infinite                 = false;
    // start at the target colour
    mod_colour_lerp_initial             = false;
    mod_colour_max_frame                = _max_frame;
    colour                              = mod_colour_initial_colour;
    _start_mod_colour_alarm(3);
}

function start_pulse_colour_cycled(_colour_target, _colour_frame_change, _colour_lerp_speed, _max_cycle){
    mod_colour_target_colour            = _colour_target;
    mod_colour_frame_change             = _colour_frame_change;
    mod_colour_lerp_speed               = _colour_lerp_speed;
    mod_colour_infinite                 = false;
    // start at the target colour
    mod_colour_lerp_initial             = false;
    mod_colour_max_cycle                = _max_cycle;
    colour                              = mod_colour_initial_colour;
    _start_mod_colour_alarm(3);
}

function _alarm_pulse_colour_loop(){
    if(mod_colour_infinite == false && mod_colour_current_frame == mod_colour_max_frame || mod_colour_current_cycle == mod_colour_max_cycle){
        stop_mod_colour();
        exit;
    }

    if(mod_colour_lerp_initial == true){
        colour = lerp_colour(colour, mod_colour_initial_colour, mod_colour_lerp_speed);
    }
    else{
        colour = lerp_colour(colour, mod_colour_target_colour, mod_colour_lerp_speed);
    }

    mod_colour_current_frame++;
    
    if(mod_colour_current_frame = mod_colour_frame_change){
        mod_colour_current_frame = 0;
        if(mod_colour_current_cycle != undefined){
            mod_colour_current_cycle++;
        }
        mod_colour_lerp_initial = !mod_colour_lerp_initial;
    }
    
    alarm_set(mod_colour_alarm_index, 1);
}

