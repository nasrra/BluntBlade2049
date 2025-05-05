doors = [];
doors[DoorId.TOP] = undefined;
doors[DoorId.BOT] = undefined;
doors[DoorId.LEFT] = undefined;
doors[DoorId.RIGHT] = undefined;


function spawn_player_at_door(){
    if(global.room_to_load_enter_point != undefined){
        var position = doors[global.room_to_load_enter_point].get_exit_position();
        obj_player.snap_to_position(position.x, position.y);
    }
}


function lock_doors(){
    if(instance_exists(doors[DoorId.TOP]) == true){
        doors[DoorId.TOP].set_locked();
    }
    if(instance_exists(doors[DoorId.BOT]) == true){
        doors[DoorId.BOT].set_locked();
    }
    if(instance_exists(doors[DoorId.LEFT]) == true){
        doors[DoorId.LEFT].set_locked();
    }
    if(instance_exists(doors[DoorId.RIGHT]) == true){
        doors[DoorId.RIGHT].set_locked();
    }
}

function unlock_doors(){
    if(instance_exists(doors[DoorId.TOP]) == true){
        doors[DoorId.TOP].set_unlocked();
    }
    if(instance_exists(doors[DoorId.BOT]) == true){
        doors[DoorId.BOT].set_unlocked();
    }
    if(instance_exists(doors[DoorId.LEFT]) == true){
        doors[DoorId.LEFT].set_unlocked();
    }
    if(instance_exists(doors[DoorId.RIGHT]) == true){
        doors[DoorId.RIGHT].set_unlocked();
    }
}

function set_locks(){
    if(roommanager_get_room_cleared(room) == false){
        lock_doors();
    }
    else{
        unlock_doors();
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

function set_floor_door(_id){
    doors[DoorId.FLOOR] = _id;
}