if(player_entered == false && place_meeting(x,y,obj_player) == true){
    obj_ui_manager.start_room_transition(RoomTransitionMovement.TOP_TO_BOT, RoomTransitionSetup.EXIT);
    // obj_ui_manager.start_room_transition(RoomTransitionMovement.BOT_TO_TOP, RoomTransitionSetup.EXIT);
    // obj_ui_manager.start_room_transition(RoomTransitionMovement.LEFT_TO_RIGHT, RoomTransitionSetup.EXIT);
    // obj_ui_manager.start_room_transition(RoomTransitionMovement.RIGHT_TO_LEFT, RoomTransitionSetup.EXIT);
    player_entered = true;
    obj_player.block_input();
    roommanager_set_room_to_load(room_to_goto, point_to_spawn_at);
}