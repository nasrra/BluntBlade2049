event_inherited();
if(instance_exists(light) == false){
	exit;
}
light.size = lerp(light.size, light_target_size, 0.75);
if(abs(light.size - light_target_size) <= 0.1){
	light.size = light_target_size;
	light_target_size = (light_target_size == light_max_size)? 0 : light_max_size;
}