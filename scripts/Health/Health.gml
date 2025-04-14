function HealthPoints(_max_value, _current_value) constructor{
    current_value = _current_value;
    max_value = _max_value;
    invincible = false;
    on_damage = new EventAction();
    on_death  = new EventAction();
    on_heal   = new EventAction();

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

    function heal(_amount){
        current_value += _amount;
        on_heal.invoke();
        if(current_value > max_value){
            current_value = max_value;
        }
    }

    function now_invincible(){
        invincible = true;
        show_debug_message("invincible!");
    }

    function not_invincible(){
        invincible = false;
        show_debug_message("no longer invincible!");
    }
}