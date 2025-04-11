/// @description Insert description here
// You can write your code in this editor
if(parry_cbox_active == true){
    draw_set_color(c_yellow);  // Set the color to yellow for visibility
    
    // Define the rectangle bounds
    var left = parry_cbox_x - parry_cbox_width / 2;
    var top = parry_cbox_y - parry_cbox_height / 2;
    var right = parry_cbox_x + parry_cbox_width / 2;
    var bottom = parry_cbox_y + parry_cbox_height / 2;

    // Draw the rectangle (only outline, not filled)
    draw_rectangle(left, top, right, bottom, true);
    draw_set_color(c_white);  // Set the color to yellow for visibility
}
draw_self();