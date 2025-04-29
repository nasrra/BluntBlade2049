/// @description Insert description here
// You can write your code in this editor
element_type = undefined;
previous_frame_collision_map = ds_map_create();
status_charges = 3;
player_entered = false;

function check_collisions(){
	current_frame_collision_map = ds_map_create();

    if(place_meeting(x,y,obj_player) == true){
		if(player_entered == false && obj_player.element_status.status != element_type){
			obj_player.element_status.set_status(element_type);
			player_entered = true;
			_lower_status_charges();
		}
	}
	else{
		player_entered = false;
	}

	// check and add all colliding enemies to the current frame map.
	in_zone = ds_list_create();
	instance_place_list(x,y,obj_enemy,in_zone,false);
	for(var i = 0; i < ds_list_size(in_zone); i++){
		var list_instance = ds_list_find_value(in_zone, i);
		if(ds_map_find_value(previous_frame_collision_map, list_instance.id) == undefined){
			// entered the collision area.
			list_instance.element_status.set_status(element_type);
		}
		ds_map_add(current_frame_collision_map, list_instance.id, true);
	}

	var key = undefined;
	if(ds_exists(previous_frame_collision_map, ds_type_map)){
		key = ds_map_find_first(previous_frame_collision_map);
	}
	while(key != undefined){
		var _instance_id = ds_map_find_value(current_frame_collision_map,key);
		if(_instance_id == undefined){
			// left the colliding area.
			_lower_status_charges();
		}
		key = ds_map_find_next(previous_frame_collision_map, key);
	}

	// swap the collision maps.
	ds_map_destroy(previous_frame_collision_map);
	previous_frame_collision_map = current_frame_collision_map;
	ds_list_destroy(in_zone);
}

function _lower_status_charges(){
	status_charges--;
	if(status_charges <= 0){
		instance_destroy();
	}
}