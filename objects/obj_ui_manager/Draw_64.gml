/// @description Insert description here
// You can write your code in this editor
switch(global.game_state){
    case GameState.GAMEPLAY:
        healthbar_hearts();
        show_debug_message(0); 
        break;
    case GameState.DEATH:
        death_background();
        death_text();
        death_input();
        show_debug_message(1); 
        break;
}