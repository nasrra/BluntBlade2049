/// @description Insert description here
// You can write your code in this editor
if(decrease_fire_light_size == true){
		fire_light_target_size = random_range(fire_light_start_size-fire_light_crackle_range, fire_light_start_size);
}
else{
	fire_light_target_size = random_range(fire_light_start_size, fire_light_start_size+fire_light_crackle_range);
}

decrease_fire_light_size = !decrease_fire_light_size;

alarm_set(0,6);