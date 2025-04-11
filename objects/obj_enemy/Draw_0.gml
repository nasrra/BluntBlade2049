/// @description Insert description here
// You can write your code in this editor
if(weapon.angle >= 0 && weapon.angle < 180){
    // draw weapon behind enemy.
    draw_weapon();
}
draw_self();
if(weapon.angle >= 180 && weapon.angle < 360){
    // draw weapon in front enemy.
    draw_weapon();
}