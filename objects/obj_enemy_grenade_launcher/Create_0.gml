/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
if(should_destroy == true){
	exit;
}
id.weapon = GunGrenadeLauncher(id,0);
id.weapon.swivel_speed = 0.1;
id.weapon.start_shoot_loop();
movement.initialise(id, 2, 1, 1);