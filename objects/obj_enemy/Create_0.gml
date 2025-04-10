/// @description Insert description here
// You can write your code in this editor

target = obj_player;
weapon_angle = direction;
weapon_swivel_speed = 0.1;
weapon_offset_x = 16;
weapon_offset_y = 16;
weapon_length = 16; 

function fire_bullet(){
    var offset_x = lengthdir_x(weapon_length + weapon_offset_x, weapon_angle);
    var offset_y = lengthdir_y(weapon_length + weapon_offset_y, weapon_angle);
    var bullet_instance  = instance_create_layer(x + offset_x, y + offset_y, "Bullets", bullet_object);
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

function face_target(){
    if(direction >= 330 || direction <= 45){
        // show_debug_message("face_right");        
    }
    else if(direction >= 45 && direction <= 135){
        // show_debug_message("face_up");
    }
    else if(direction >= 135 && direction <= 225){
        // show_debug_message("face_left");
    }
    else if(direction >= 225 && direction <= 330){
        // show_debug_message("face_down");
    }
}

function damage(_amount){
    id.health -= _amount;
    show_debug_message(id.health);
    if(id.health <= 0){
        instance_destroy();
    }
}

function calculate_weapon_angle(){
    var true_angle = weapon_angle + angle_difference(direction, weapon_angle) * weapon_swivel_speed;
    var clamped_angle = (true_angle % 360 + 360) % 360;
    weapon_angle = clamped_angle;
}

function draw_weapon(){
    var weapon_y_scale = (direction > 90 && direction < 270)? -1 : 1;
    var offset_x = lengthdir_x(weapon_offset_x, weapon_angle);
    var offset_y = lengthdir_y(weapon_offset_y, weapon_angle);
    draw_sprite_ext(spr_gun, 0, x + offset_x, y + offset_y, 1, weapon_y_scale, weapon_angle, c_white, 1); // draw weapon.
}