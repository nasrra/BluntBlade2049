/// @description Insert description here
// You can write your code in this editor
if(instance_exists(particles)){
	instance_destroy(particles);
}
if(instance_exists(light)){
	instance_destroy(light);
}

if(ds_exists(hit_objects, ds_type_map) == true){
	ds_map_destroy(hit_objects);
}