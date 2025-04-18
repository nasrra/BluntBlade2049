/// @description light pulser

ambient_light.size = lerp(ambient_light.size, target_size, 0.15);
if(abs(ambient_light.size-target_size) <= 0.1){
	target_size = (target_size == max_size)? 0 : max_size;
}
alarm_set(0, 1);
