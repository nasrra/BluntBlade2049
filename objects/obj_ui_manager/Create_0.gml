/// @description Insert description here
// You can write your code in this editor
gui_w = display_get_gui_width();
gui_h = display_get_gui_height();





// healthbar draw calls.

healthbar_heart_amount = 0;
healthbar_start_x = 10;
healthbar_start_y = 10;
healthbar_heart_spacing = 20;
healthbar_heart_scale = 4;

function update_healthbar(_amount){
    healthbar_heart_amount = _amount;
}

function healthbar_hearts(){
    for(var i = 0; i < healthbar_heart_amount; i++){
        var x_offset = (healthbar_start_x * healthbar_heart_scale) + healthbar_heart_spacing * i * healthbar_heart_scale;
        var y_offset = healthbar_start_y * healthbar_heart_scale;
        draw_sprite_ext(
            spr_healthbar_heart,
            0, 
            x_offset, 
            y_offset, 
            healthbar_heart_scale, 
            healthbar_heart_scale,
            image_angle,
            image_blend,
            image_alpha
        );
    }
}





// death draw calls.

function death_background(){
    draw_set_alpha(0.75);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    draw_set_color(c_white);
}

function death_text(){
    var text = "[DEATH]";
    var size = 10;

    draw_set_font(font_1);
    draw_set_color(c_white);

    var text_w = string_width(text) * size;
    var text_h = string_height(text) * size;

    draw_text_transformed(
        (gui_w / 2) - (text_w * 0.5),
        (gui_h / 2) - (gui_h*0.25),
        text,
        size,
        size,
        0
    );


    text = "|Press [ANY KEY] to Restart|";
    size = 2.5;
    text_w = string_width(text) * size;
    text_h = string_height(text) * size;

    draw_text_transformed(
        (gui_w / 2) - (text_w * 0.5),
        (gui_h / 2) + (gui_h*0.05),
        text,
        size,
        size,
        0
    );
}

function death_input(){
    var input = keyboard_check_pressed(vk_anykey);
    if(input == true){
        room_restart();
        gamemanager_gameplay_state();
    }
}