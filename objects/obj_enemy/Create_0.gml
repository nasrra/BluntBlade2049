/// @description Insert description here
// You can write your code in this editor

target = obj_player;
weapon_swivel_speed = 0.1;
weapon = struct_gun_shotgun();

function fire_bullet(){
    var bullets = weapon.shoot();
    for(var i = 0; i < array_length(bullets); i++){
        bullets[i].sender = id;
    }
}

fire_bullets_counter = 0;
fire_bullets_alarm_index = 0;
function fire_bullets(_amount){
    fire_bullets_counter = _amount;
    alarm_set(fire_bullets_alarm_index, 1);
}

function _fire_bullets(){
    if(fire_bullets_counter > 0){
        fire_bullet();
        alarm_set(fire_bullets_alarm_index, id.weapon.fire_rate);
        if(infinite_fire == false){
            fire_bullets_counter -= 1;
        }
    }
    else{
        fire_bullets_counter    = 0;
    }
}

function move_to_target(){
    if(instance_exists(target)==false){
        exit;
    }
    
    direction = point_direction(x,y,target.x,target.y);
    x += lengthdir_x(move_speed, direction);
    y += lengthdir_y(move_speed, direction);
}   

function update_weapon(){
    weapon.x        = x;
    weapon.y        = y;
    weapon.angle    = calculate_weapon_angle();
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
    var true_angle = weapon.angle + angle_difference(direction, weapon.angle) * weapon_swivel_speed;
    var clamped_angle = (true_angle % 360 + 360) % 360;
    return clamped_angle;
}

function draw_weapon(){
    var weapon_y_scale = (direction > 90 && direction < 270)? -1 : 1;
    var offset_x = lengthdir_x(id.weapon.offset_x, id.weapon.angle);
    var offset_y = lengthdir_y(id.weapon.offset_y, id.weapon.angle);
    draw_sprite_ext(id.weapon.sprite, 0, x + offset_x, y + offset_y, 1, weapon_y_scale, id.weapon.angle, c_white, 1); // draw weapon.
}
update_weapon();