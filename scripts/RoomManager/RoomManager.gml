global.room_to_load_enter_point = undefined;
global.room_to_load = undefined;

function roommanager_set_room_to_load(_room, _enter_point){
    global.room_to_load             = _room;
    global.room_to_load_enter_point = _enter_point;
}

function roommanager_goto_room(){
    room_goto(global.room_to_load);
}