global.game_state = undefined;

enum GameState{
    DEATH,
    GAMEPLAY,
    MENU,
}

function gamemanager_death_state(){
    global.game_state = GameState.DEATH;
    uimanager_enable_death_ui();
}

function gamemanager_gameplay_state(){
    global.game_state = GameState.GAMEPLAY;
    uimanager_enable_gameplay_ui();
}

function gamemanager_menu_state(){
    global.game_state = GameState.MENU;
}

randomize();