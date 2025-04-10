/// @description Insert description here
// You can write your code in this editor
if(weapon_angle >= 0 && weapon_angle < 180){
    // draw weapon behind enemy.
    draw_weapon();
}
draw_self();
if(weapon_angle >= 180 && weapon_angle < 360){
    // draw weapon in front enemy.
    draw_weapon();
}