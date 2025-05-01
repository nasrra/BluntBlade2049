/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
if(should_destroy == true){
	exit;
}
id.weapon = GunRevolver(id,0);
id.weapon.swivel_speed = 0.1;
weapon.start_shoot_loop();
movement.initialise(id, 4.25, 1, 1);
