/// @description Insert description here
// You can write your code in this editor
function room_check(){
    if(roommanager_get_room_cleared(room) == true && destroy_if_room_cleared == true){
        instance_destroy();
    }
}

on_pickup = new EventAction();