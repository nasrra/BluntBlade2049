/// @description Insert description here
// You can write your code in this editor
switch(global.game_state){
    case GameState.GAMEPLAY:
        draw_healthbar_hearts();
        break;
    case GameState.DEATH:
        draw_death_background();
        draw_death_text();
        death_input();
        break;
}

draw_crt_lines();

if(room_transition_active == true){
    draw_room_transition();
}

