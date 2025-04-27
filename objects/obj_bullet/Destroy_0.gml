/// @description Insert description here
// You can write your code in this editor
if(instance_exists(light) == true){
	instance_destroy(light);
}

if(instance_exists(trail_particle) == true){
	trail_particle.smooth_destroy(60);
}
_spawn_hit_particle();