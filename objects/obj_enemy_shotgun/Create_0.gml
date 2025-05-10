/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
if(should_destroy == true){
	exit;
}
id.weapon = GunShotgun(id,0);
id.weapon.swivel_speed = 0.1;
id.weapon.start_shoot_loop();
movement.initialise(id, 3, 1, 1);
sprite_left     = spr_enemy_revolver_l;
sprite_right    = spr_enemy_revolver_r;
sprite_down     = spr_enemy_revolver_d;
sprite_up       = spr_enemy_revolver_u;
