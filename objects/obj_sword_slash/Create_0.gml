collisions = undefined;
all_collisions = ds_map_create();
on_hit_bullet = new EventAction();
on_hit_enemy = new EventAction();
on_hit_dyn_environment = new EventAction();

function _check_collisions(){
    _check_collision_against_object(obj_enemy, on_hit_enemy);
    _check_collision_against_object(obj_bullet, on_hit_bullet);
    _check_collision_against_object(obj_dyn_environment, on_hit_dyn_environment);
}

function _check_collision_against_object(_object, _callback){
    collisions = ds_map_create();
    collisions_list = ds_list_create();
    instance_place_list(x, y, _object, collisions_list, false);
    for(var i = 0; i < ds_list_size(collisions_list); i++){
        if(ds_exists(all_collisions, ds_type_map) == false){
            continue;
        }
        if(all_collisions[? collisions_list[| i]] == undefined){
            ds_map_add(collisions, collisions_list[| i], true);
            ds_map_add(all_collisions, collisions_list[| i], true);
        }
    }

    // if(variable_instance_exists(self, "on_hit_enemy") && ds_map_size(collisions) > 0){
    if(ds_map_size(collisions) > 0){
        _callback.invoke();
    }

    ds_list_destroy(collisions_list);
    ds_map_destroy(collisions);

}