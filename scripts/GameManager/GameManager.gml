global.game_state = undefined;

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

gamemanager_gameplay_state();

randomize();