global.player_health = undefined;

function player_set_global_health(_amount){
    global.player_health = _amount;
    show_debug_message(string_join(" ","[=] global.player_health:", global.player_health));
}

function player_get_global_health(){
    return global.player_health;
}