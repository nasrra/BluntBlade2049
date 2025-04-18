/// @description Insert description here
// You can write your code in this editor
if(weapon.angle >= 0 && weapon.angle < 180){
    // draw weapon behind enemy.
    weapon.draw();
}

draw_self();
damage_flash.draw();


if(weapon.angle >= 180 && weapon.angle < 360){
    // draw weapon in front enemy.
    weapon.draw();
}

// draw_set_alpha(0.1);
// draw_path(movement_path, x, y, 1);
// draw_set_alpha(1);
