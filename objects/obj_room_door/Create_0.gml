player_entered = false;
locked = true;
room_transition_movement = undefined;

function handle_collisions(){
    if(locked == false && player_entered == false && place_meeting(x,y,obj_player) == true){
        if(room_transition_movement == undefined){
            show_debug_message("[ERROR]: door transition movement is undefined!");
            exit;
        }
        obj_ui_manager.start_room_transition(room_transition_movement, RoomTransitionSetup.EXIT);
        player_entered = true;
        obj_player.block_input();
        roommanager_set_room_to_load(room_to_goto, point_to_spawn_at);
    }
}