/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
id.weapon = GunShotgun(id,0);
id.weapon.swivel_speed = 0.1;
id.weapon.start_shoot_loop();
movement.initialise(id, 3, 1, 1);
