/// @description Insert description here
// You can write your code in this editor

target = obj_player;

function fire_bullet(){
    var bullet_instance  = instance_create_layer(x, y, "Bullets", bullet_object);
    bullet_instance.sender = id;
}

fire_bullets_counter = 0;
fire_bullets_interval = 0;
fire_bullets_alarm_index = 0;
function fire_bullets(_amount, _interval){
    fire_bullets_counter = _amount;
    fire_bullets_interval = _interval;
    alarm_set(fire_bullets_alarm_index, 1);
}

function _fire_bullets(){
    if(fire_bullets_counter > 0){
        fire_bullet();
        alarm_set(fire_bullets_alarm_index, fire_bullets_interval);
        if(infinite_fire == false){
            fire_bullets_counter -= 1;
        }
    }
    else{
        fire_bullets_counter    = 0;
        fire_bullets_interval   = 0;
    }
}

function move_to_target(){
    direction = point_direction(x,y,target.x,target.y);
    x += lengthdir_x(move_speed, direction);
    y += lengthdir_y(move_speed, direction);
}