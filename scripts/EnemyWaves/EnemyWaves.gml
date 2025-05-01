function enemy_waves_room_test(){
	return [
		[obj_enemy_revolver, obj_enemy_burst_rifle, obj_enemy_shotgun, obj_enemy_grenade_launcher],
		[obj_enemy_revolver, obj_enemy_grenade_launcher, obj_enemy_shotgun, obj_enemy_burst_rifle],
		[obj_enemy_revolver, obj_enemy_burst_rifle, obj_enemy_grenade_launcher, obj_enemy_shotgun],
		// [obj_enemy_revolver, undefined, obj_enemy_shotgun, undefined],
	];
}

function enemy_waves_room_floor_1_1(){
	return [
		[obj_enemy_revolver, obj_enemy_revolver, obj_enemy_revolver, obj_enemy_revolver],
		// [obj_enemy_revolver, obj_enemy_revolver, obj_enemy_revolver, obj_enemy_revolver],
		// [obj_enemy_revolver, obj_enemy_revolver, obj_enemy_revolver, obj_enemy_revolver],
	];
}