/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();


move = function move(){
    // calc move direction, normalising the vector so we dont go faster diagonally.
    // move_dir = point_direction(0,0,input_x, input_y);
    var move_x = lengthdir_x(current_speed, move_dir);
    var move_y = lengthdir_y(current_speed, move_dir);
    with(entity_id){
        // show_debug_message(0);
        move_and_collide(move_x, move_y, obj_environment);
    }
}
