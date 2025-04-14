doors = [];

function spawn_player_at_door(){
    if(global.room_to_load_enter_point != undefined){
        var position = doors[global.room_to_load_enter_point].get_exit_position();
        obj_player.snap_to_position(position.x, position.y);
    }
}

function set_top_door(_id){
    doors[DoorId.TOP] = _id;
}

function set_bot_door(_id){
    doors[DoorId.BOT] = _id;
}

function set_left_door(_id){
    doors[DoorId.LEFT] = _id;
}

function set_right_door(_id){
    doors[DoorId.RIGHT] = _id;
}