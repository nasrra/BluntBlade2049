global.game_state = undefined;
global.tutorial_completed = false;

enum GameState{
    DEATH,
    GAMEPLAY,
    MENU,
}

function gamemanager_death_state(){
    global.game_state = GameState.DEATH;
}

function gamemanager_gameplay_state(){
    global.game_state = GameState.GAMEPLAY;
}

function gamemanager_menu_state(){
    global.game_state = GameState.MENU;
}

function gamemanager_restart_game(){
    roommanager_reset_data();
    roommanager_set_starting_room_to_load();
    obj_ui_manager.start_room_transition(RoomTransitionMovement.BOT_TO_TOP, RoomTransitionSetup.EXIT);
    gamemanager_gameplay_state();
}

function gamemanager_set_tutorial_complete(){
    global.tutorial_completed = true;
}

function gamemanager_is_tutorial_complete(){
    return global.tutorial_completed; 
}

gamemanager_gameplay_state();

randomize();