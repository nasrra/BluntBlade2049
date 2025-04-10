target          = obj_player;

// 480p for pixel art stuff.
camera_width       = 960;
camera_height      = 540;

smooth_factor   = 0.1;

previous_x = target.y;
previous_y = target.x;
target_x = target.x;
target_y = target.y;

offset_x = 0;
offset_y = 0;

function update_position(){
    // set position to centre in on the target.
    target_x = target.x - (camera_width * 0.5);
    target_y = target.y - (camera_height * 0.5);

    // add offset.
    target_x += offset_x;
    target_y += offset_y;

    // clamp the x and y of the camera so it desnt go outside of the room.
    target_x = clamp(target_x, 0, room_width - camera_width);
    target_y = clamp(target_y, 0, room_height - camera_height);

    // lerp to desired position.
    target_x = lerp(previous_x, target_x, smooth_factor);
    target_y = lerp(previous_y, target_y, smooth_factor);
    previous_x = target_x;
    previous_y = target_y;
    
    camera_set_view_pos(view_camera[0], target_x, target_y);
}

function handle_input(){
    if(keyboard_check_pressed(vk_alt)){
        invoke_shake_camera();
    }
}


shake_amount        = 75;
shake_max_count     = 15;
shake_current_count = 0;
shake_interval      = 1;
shake_alarm_index   = 0;
function invoke_shake_camera(){
    shake_current_count = shake_max_count;
    alarm_set(shake_alarm_index, 1);
}

function shake_camera(){
    if(shake_current_count > 0){
        shake_current_count -= 1;
        offset_x = random_range(-shake_amount, shake_amount);
        offset_y = random_range(-shake_amount, shake_amount);
        alarm_set(shake_alarm_index, shake_interval);
    }
    else{
        offset_x = 0;
        offset_y = 0;
    }
}


