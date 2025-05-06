/// @description Insert description here
// You can write your code in this editor
on_tick_damage  = new EventAction();
on_damage       = new EventAction();
on_death        = new EventAction();
on_heal         = new EventAction();
on_invincible   = new EventAction();
on_vincible     = new EventAction();
current_value   = undefined;
max_value       = undefined;
tick_damage_loop_frame_time = undefined;
tick_damage_loop_cycle      = undefined;
tick_damage_loop_max_cycle  = undefined;
tick_damage_value           = undefined;
invincible = false;

function initialise(_max_value, _current_value){
    current_value = _current_value;
    max_value = _max_value;
}

function damage(_amount){
    if(invincible == true){
        return;
    }
    // show_debug_message(current_value);
    current_value -= _amount;
    on_damage.invoke();
    if(current_value <= 0){
        on_death.invoke();
    }
}

function tick_damage(_amount){
    if(invincible == true){
        return;
    }
    current_value -= _amount;
    on_tick_damage.invoke();
    if(current_value <= 0){
        on_death.invoke();
    } 
}

function start_tick_damage_loop(_tick_damage, _max_cycle, _time_in_frames){
    // show_debug_message("start tick damage loop!");
    tick_damage_loop_frame_time = _time_in_frames;
    tick_damage_loop_max_cycle = _max_cycle;
    tick_damage_loop_cycle = 0;
    tick_damage_value = _tick_damage;
    alarm_set(1,_time_in_frames);
}

function _tick_damage_loop(){
    if(tick_damage_loop_cycle == tick_damage_loop_max_cycle){
        exit;
    }
    tick_damage(tick_damage_value);
    tick_damage_loop_cycle++;
    alarm_set(1,tick_damage_loop_frame_time);
}

function stop_tick_damage_loop(){
    alarm_set(1,0);
}

function heal(_amount){
    current_value += _amount;
    if(current_value > max_value){
        current_value = max_value;
    }
    on_heal.invoke();
}

function set_invincible_timed(_frames){
    set_invincible();
    alarm_set(0,_frames);
}

function set_invincible(){
    // show_debug_message("invincible!");
    invincible = true;
    on_invincible.invoke();
}

function set_vincible(){
    // show_debug_message("vincible!");
    invincible = false;
    on_vincible.invoke();
}
