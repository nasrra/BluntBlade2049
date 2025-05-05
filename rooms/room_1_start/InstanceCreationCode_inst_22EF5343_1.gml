if(global.current_floor != room || global.current_floor == undefined){
	global.current_floor = room;
	roommanager_set_floor_rooms_to_clear(8);
}