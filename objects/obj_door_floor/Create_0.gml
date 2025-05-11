event_inherited();
if(roommanager_is_floor_cleared() == false){
	set_locked();
}
else{
	room_transition_movement = RoomTransitionMovement.BOT_TO_TOP;
	room_to_goto_enter_point = DoorId.FLOOR;
	set_unlocked();
}

// room_transition_movement = RoomTransitionMovement.BOT_TO_TOP;
// room_to_goto_enter_point = DoorId.FLOOR;
// set_unlocked();

on_enter = function(){
	obj_player.hp.current_value = 5;
	player_set_global_health(5);
}

obj_door_manager.set_floor_door(id);