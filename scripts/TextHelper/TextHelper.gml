// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function texthelper_get_gui_center_x(_string, _size){
    var gui_w = display_get_gui_width();
    var text_w = string_width(_string) * _size;
    return (gui_w * 0.5) - (text_w * 0.5);
}


function texthelper_get_gui_center_y(_string, _size){
    var gui_h = display_get_gui_height();
    var text_h = string_height(_string) * _size;
    return (gui_h * 0.5) - (text_h * 0.5);
}