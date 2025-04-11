gui_w = display_get_gui_width();
gui_h = display_get_gui_height();

function draw_background(){
    draw_set_alpha(0.75);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    draw_set_color(c_white);
}

function draw_display_text(){
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

function handle_input(){
    var input = keyboard_check_pressed(vk_anykey);
    if(input == true){
        room_restart();
    }
}