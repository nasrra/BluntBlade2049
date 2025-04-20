/// @description Insert description here
// You can write your code in this editor
if(instance_exists(light) == true){
	instance_destroy(light);
}

if(instance_exists(particles) == true){
	particles.smooth_destroy(60);
}