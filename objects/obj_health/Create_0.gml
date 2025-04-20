/// @description Insert description here
// You can write your code in this editor
current_value = undefined;
max_value = undefined;
invincible = false;
on_tick_damage  = new EventAction();
on_damage       = new EventAction();
on_death        = new EventAction();
on_heal         = new EventAction();
on_invincible   = new EventAction();
on_vincible     = new EventAction();

function initialise(_max_value, _current_value){
    current_value = _current_value;
    max_value = _max_value;
}

function damage(_amount){
    if(invincible == true){
        return;
    }
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

function heal(_amount){
    current_value += _amount;
    on_heal.invoke();
    if(current_value > max_value){
        current_value = max_value;
    }
}

function set_invincible_timed(_frames){
    set_invincible();
    alarm_set(0,_frames);
}

function set_invincible(){
    show_debug_message("invincible!");
    invincible = true;
    on_invincible.invoke();
}

function set_vincible(){
    show_debug_message("vincible!");
    invincible = false;
    on_vincible.invoke();
}
