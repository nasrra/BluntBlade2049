/// @description Insert description here
// You can write your code in this editor
with(id){
    obj_enemy_manager.remove_enemy();
	if(variable_instance_exists(self, "element_status") == true && instance_exists(element_status) == true){
		instance_destroy(element_status);
	}
	if(variable_instance_exists(self, "light") == true && instance_exists(light) == true){
		instance_destroy(light);
	}
	if(variable_instance_exists(self, "damage_particle") == true && instance_exists(damage_particle) == true){
		damage_particle.smooth_destroy(60);
	}
	if(variable_instance_exists(self, "hp") == true && instance_exists(hp) == true){
		instance_destroy(hp);
	}
	if(variable_instance_exists(self, "movement") == true && instance_exists(movement) == true){
		instance_destroy(movement);
	}
}