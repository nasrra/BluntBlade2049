global.room_enter_point = "";

function roommanager_goto_room(_room, _enter_point){
    global.room_enter_point = _enter_point;
    room_goto(_room);
}