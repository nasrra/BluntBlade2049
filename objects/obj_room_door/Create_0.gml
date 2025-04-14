player_entered = false;
locked = false;
room_transition_movement = undefined;
room_to_goto_enter_point = undefined; // the door the player enters from in the next room.

function handle_collisions(){
    if(locked == false && player_entered == false && place_meeting(x,y,obj_player) == true){
        if(room_transition_movement == undefined){
            show_debug_message("[ERROR]: door transition movement is undefined!");
            exit;
        }
        player_entered = true;
        obj_player.block_input();
        roommanager_set_room_to_load(room_to_goto, room_to_goto_enter_point);
        obj_ui_manager.start_room_transition(room_transition_movement, RoomTransitionSetup.EXIT);
    }
}

function get_exit_position(){
    return new Vector2(x+exit_position_x, y+exit_position_y);
}