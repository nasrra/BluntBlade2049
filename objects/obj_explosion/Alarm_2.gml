/// @description Insert description here
// You can write your code in this editor
if(instance_exists(light)){
	instance_destroy(light);
}
instance_destroy();
show_debug_message("Explosion Destroyed!");