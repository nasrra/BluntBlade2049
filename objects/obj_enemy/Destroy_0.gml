/// @description Insert description here
// You can write your code in this editor
with(id){
    obj_enemy_manager.remove_enemy();
	if(instance_exists(ambient_light) == true){
		instance_destroy(ambient_light);
	}
}