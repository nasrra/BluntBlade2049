global.game_state = GameState.GAMEPLAY;

enum GameState{
    DEATH,
    GAMEPLAY,
    MENU,
}

function death_state(){
    global.game_state = GameState.DEATH;
}

function gameplay_state(){
    global.game_state = GameState.GAMEPLAY;
}

function menu_state(){
    global.game_state = GameState.MENU;
}