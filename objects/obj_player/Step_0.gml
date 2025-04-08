/// @description Insert description here
// You can write your code in this editor
input_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
input_y = keyboard_check(ord("S")) - keyboard_check(ord("W"));

if(input_x == 0 && input_y == 0){
    current_speed = lerp(current_speed,0,deceleration);
}
else{
    current_speed = lerp(current_speed,max_speed,acceleration); 
    move_dir = point_direction(0, 0, input_x, input_y);
}

// calc move direction, normalising the vector so we dont go faster diagonally.
// move_dir = point_direction(0,0,input_x, input_y);
move_x = lengthdir_x(current_speed, move_dir);
move_y = lengthdir_y(current_speed, move_dir);

move_and_collide(move_x, move_y, obj_collision);