global.room_to_load_enter_point = undefined;
global.room_to_load = undefined;
global.room_clears = undefined;
global.floor_rooms_to_clear = undefined; // start on floor one.
global.current_floor = undefined;
global.starting_room = asset_get_index("room_1_start");

function roommanager_set_room_to_load(_room, _enter_point){
    global.room_to_load             = _room;
    global.room_to_load_enter_point = _enter_point;
}

function roommanager_goto_room(){
    if(global.room_to_load != undefined){
        room_goto(global.room_to_load);
    }
}


function roommanager_intialise_room_persistence_data(){
    var index = 0;
	var room_name = undefined;
    if(global.room_clears != undefined){
        show_debug_message("destroy room clears!");
        ds_map_destroy(global.room_clears);
    }
    global.room_clears = ds_map_create();
    while(room_exists(index)){
		room_name = room_get_name(index);
        // if the room name doesnt contain 'start' or menu.
        if(string_pos("menu", room_get_name(index)) <= 0){
            // add the room clears data to it.
            ds_map_add(global.room_clears,room_name,string_pos("start", room_get_name(index))? true : false); 
        }
        index++;
    }
}

function roommanager_set_room_cleared(_room_index, _cleared){
    var name = room_get_name(_room_index);
    ds_map_replace(global.room_clears, name, _cleared);
}

function roommanager_set_floor_rooms_to_clear(_amount){
    global.floor_rooms_to_clear = _amount;
    show_debug_message(string_join(" ", "[=] floor_rooms_to_clear: ", global.floor_rooms_to_clear));
}

function roommanager_increment_floor_rooms_to_clear(){
    global.floor_rooms_to_clear += 1;
    show_debug_message(string_join(" ", "[+] floor_rooms_to_clear: ", global.floor_rooms_to_clear));
}

function roommanager_decrement_floor_rooms_to_clear(){
    global.floor_rooms_to_clear -= 1;
    show_debug_message(string_join(" ", "[-] floor_rooms_to_clear: ", global.floor_rooms_to_clear));
}

function roommanager_is_floor_cleared(){
    return global.floor_rooms_to_clear <= 0;
}

function roommanager_get_room_cleared(_room_index){
    return global.room_clears[? room_get_name(_room_index)];
}

function roommanager_set_starting_room_to_load(){
    global.room_to_load_enter_point = undefined;
    global.room_to_load = global.starting_room;
}

function roommanager_reset_data(){
    global.room_to_load_enter_point = undefined;
    global.room_to_load = undefined;
    global.room_clears = undefined;
    global.floor_rooms_to_clear = undefined; // start on floor one.
    global.current_floor = undefined;
    roommanager_intialise_room_persistence_data();    
}

roommanager_intialise_room_persistence_data();