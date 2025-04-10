/// @description Insert description here
// You can write your code in this editor
direction = point_direction(0,0,0,0);

// whom this bullet was sent from.
sender = undefined;
object_to_damage = obj_player;

function move_in_direction(_move_dir){
    direction = _move_dir;
}

function move_to_point(_point){
    direction = point_direction(x,y,_point.x, _point.y);
}

function move(){
    x += lengthdir_x(speed, direction);
    y += lengthdir_y(speed, direction);
}

function send_back_to_sender(){
    move_to_point(sender);
}

function set_object_to_damage(_object){
    object_to_damage = _object;
}

function check_collisions(){
    var hit = instance_place(x,y,object_to_damage);
    if(hit != noone){
        hit.damage(damage);
        instance_destroy();
    }
}