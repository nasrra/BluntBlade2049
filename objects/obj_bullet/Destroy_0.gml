/// @description Insert description here
// You can write your code in this editor
if(instance_exists(light) == true){
	instance_destroy(light);
}

if(trail_part_system != undefined){
	if(trail_emitter != undefined){
		part_emitter_destroy(trail_part_system, trail_emitter);
	}
	part_system_destroy(trail_part_system);
}

if(trail_particle != undefined){
	part_type_destroy(trail_particle);
}