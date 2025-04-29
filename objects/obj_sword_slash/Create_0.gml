collisions = undefined;
all_collisions = ds_map_create();

function _check_collisions(){
    collisions = ds_map_create();
    collisions_list = ds_list_create();
    
    instance_place_list(x, y, obj_bullet, collisions_list, false);
    for(var i = 0; i < ds_list_size(collisions_list); i++){
        if(all_collisions[? collisions_list[| i]] == undefined){
            ds_map_add(collisions, collisions_list[| i], true);
            ds_map_add(all_collisions, collisions_list[| i], true);
        }
    }
    if(variable_instance_exists(self, "on_hit_bullet") && ds_map_size(collisions) > 0){
        on_hit_bullet.invoke();
    }

    ds_list_destroy(collisions_list);
    ds_map_destroy(collisions);

    collisions = ds_map_create();
    collisions_list = ds_list_create();
    instance_place_list(x, y, obj_enemy, collisions_list, false);
    if(ds_list_size(collisions_list) > 0){
        if(all_collisions[? collisions_list[| i]] == undefined){
            ds_map_add(collisions, collisions_list[| i], true);
            ds_map_add(all_collisions, collisions_list[| i], true);
        }
    }

    if(variable_instance_exists(self, "on_hit_enemy") && ds_map_size(collisions) > 0){
        on_hit_enemy.invoke();
    }

    ds_list_destroy(collisions_list);
    ds_map_destroy(collisions);
}