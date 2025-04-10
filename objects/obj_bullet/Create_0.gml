/// @description Insert description here
// You can write your code in this editor
speed       = 5;

function move_in_direction(_move_dir){
    direction = _move_dir;
}

function move_to_point(_point){
    direction = point_direction(x,y,_point.x, _point.y);
}

function move(){
    // move_to_point(obj_player);
    direction = point_direction(x,y, obj_player.x, obj_player.y)
    x += lengthdir_x(speed, direction);
    y += lengthdir_y(speed, direction);
}

function check_collisions(){
    if(place_meeting(x, y, obj_player)){
        // stop moving once hit player.
        direction = point_direction(0, 0, 0, 0);
        instance_destroy();
    }
}