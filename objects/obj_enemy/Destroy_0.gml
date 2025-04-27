/// @description Insert description here
// You can write your code in this editor
with(id){
    obj_enemy_manager.remove_enemy();
	if(instance_exists(element_status) == true){
		instance_destroy(element_status);
	}
	if(instance_exists(light) == true){
		instance_destroy(light);
	}
	instance_destroy(damage_particle);
	instance_destroy(hp);
}