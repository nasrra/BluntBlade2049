/// @description Insert description here
// You can write your code in this editor

parry_active            = false;
parry_timer             = 0;
parry_alarm_index       = 0;
parry_direction         = undefined;
parry_hit               = false;
parry_particle          = instance_create_layer(x,y,id.layer, obj_particle_system);
parry_particle.initialise(part_type_parry(),sprite_width*0.5,sprite_height*0.5,id);
on_parry = new EventAction();
on_hit = new EventAction();
on_element_charges_exhausted = new EventAction();
slash_object = noone;
entity_id = undefined;
element_type = ElementType.NONE;
max_element_charges = 6;
current_element_charge = max_element_charges;

function initialise(_entity_id){
    entity_id = _entity_id;
}

function parry(){
    if(parry_active == false){
        // _handle_element_status();
        parry_timer = 20;
        parry_active = true;
        slash_object = instance_create_layer(x,y,LAYER_PARTICLE,obj_sword_slash);
        slash_object.image_angle = image_angle;
        slash_object.on_hit_bullet.set(function(){handle_on_hit_bullet();});
        slash_object.on_hit_enemy.set(function(){handle_on_hit_enemy();});
        slash_object.on_hit_dyn_environment.set(function(){handle_on_hit_dyn_environment();});
        audiomanager_play_sword_swing();
        _handle_element_type();
        alarm_set(parry_alarm_index, 1);
    }
}

function update_slash_objects(){
    if(instance_exists(slash_object)==true){
        slash_object.x = x;
        slash_object.y = y;
        slash_object.image_angle = image_angle;
    }
}

function _parry_check_loop(){
    if(parry_timer > 0){
        // check collision and draw collision box.
        parry_timer -= 1;
        if(parry_hit == true){
            _parry_finish();
        }
        else{
            alarm_set(parry_alarm_index, 1);
        }
    }
    else{
        _parry_finish();
    }
}

function _parry_finish(){
    parry_active = false;
    parry_hit    = false;
}


function _handle_element_type(){
    if(element_type == ElementType.NONE){
        slash_object.sprite_index = spr_sword_slash_default;
        exit;
    }
    
    var angle = undefined;
    var parry_gun = undefined;
    switch(element_type){
        case ElementType.FIRE:
            show_debug_message("PARRY TYPE: [FIRE]");
            parry_gun = GunElementFire(id);
            slash_object.sprite_index = spr_sword_slash_fire;
            break;
        case ElementType.ELECTRIC:
            show_debug_message("PARRY TYPE: [ELECTRIC]");
            parry_gun = GunElementElectric(id);
            slash_object.sprite_index = spr_sword_slash_electric;
            break;
    }
    parry_gun.angle = image_angle;
    parry_gun.set_position(x,y);
    var bullets = parry_gun.shoot();
    for(var i = 0; i < array_length(bullets); i++){
        bullets[i].light.colour = c_white;
        bullets[i].object_to_damage = obj_enemy; 
        bullets[i].sender = entity_id;
    }
    current_element_charge--;
    if(current_element_charge == 0){
        current_element_charge = max_element_charges;
        element_type = ElementType.NONE;
        on_element_charges_exhausted.invoke();
    }
}

function handle_on_hit_enemy(){
    var enemy_hit = false;
    var wall_hit = false;
    if(slash_object.collisions == undefined || ds_exists(slash_object.collisions, ds_type_map) == false){
        exit;
    }
    var instance = ds_map_find_first(slash_object.collisions);
    while(instance != undefined && is_string(instance) == false && instance_exists(instance) == true && instance_exists(entity_id) == true){
        var wall_list = ds_list_create();
        collision_line_list(entity_id.x, entity_id.y, instance.x, instance.y, obj_environment, true, true, wall_list, true)
        for(var i = 0; i < ds_list_size(wall_list); i++){
            var wall = wall_list[| i];
            wall_hit = !wall.shoot_through;
            if(wall_hit == true){
                break;
            }
        }
        if(wall_hit == false && is_string(instance) == false && instance_exists(instance) == true){
            instance.hp.damage(1);
            enemy_hit = true;
        }
        ds_list_destroy(wall_list);
        instance = ds_map_find_next(slash_object.collisions, instance);
    }
    if(enemy_hit == true){
        // audiomanager_play_sword_hit();
        on_hit.invoke();
    }
}

function handle_on_hit_bullet(){
    var hit = false;
    var wall_hit = false;
    if (slash_object.collisions == undefined || ds_exists(slash_object.collisions, ds_type_map) == false) {
        exit;
    }
    var instance = ds_map_find_first(slash_object.collisions);
    while (instance != undefined && is_string(instance) == false && instance_exists(instance) == true && instance_exists(entity_id) == true) {
        if (variable_instance_exists(instance, "sender") && instance.sender != entity_id) {
            var wall_list = ds_list_create();
            collision_line_list(entity_id.x, entity_id.y, instance.x, instance.y, obj_environment, true, true, wall_list, true);
            wall_hit = false;
            for (var i = 0; i < ds_list_size(wall_list); i++) {
                var wall = wall_list[| i];
                wall_hit = !wall.shoot_through;
                if(wall_hit == true){
                    break;
                }
            }
            if (wall_hit == false) {
                instance.send_back_to_sender();
                instance.set_object_to_damage(obj_enemy);
                instance.sender = entity_id;
                parried = true;
                hit = true;
            }
            ds_list_destroy(wall_list);
        }
        instance = ds_map_find_next(slash_object.collisions, instance);
    }
    if (hit == true) {
        audiomanager_play_parry();
        parry_particle.x = x;
        parry_particle.y = y;
        parry_particle.set_emission_angle(image_angle - 45, image_angle + 45);
        parry_particle.emit(10);
        parry_particle.set_emission_angle(image_angle - 45 - 180, image_angle + 45 - 180);
        parry_particle.emit(10);
        parry_hit = true;
        on_parry.invoke();
    }
}

function handle_on_hit_dyn_environment(){
    var hit = false;
    var wall_hit = false;
    if (slash_object.collisions == undefined || ds_exists(slash_object.collisions, ds_type_map) == false) {
        exit;
    }
    var instance = ds_map_find_first(slash_object.collisions);
    while (instance != undefined && is_string(instance) == false && instance_exists(instance) == true && instance_exists(entity_id) == true) {
        var wall_list = ds_list_create();
        collision_line_list(entity_id.x, entity_id.y, instance.x, instance.y, obj_environment, true, true, wall_list, true);
        wall_hit = false;
        for (var i = 0; i < ds_list_size(wall_list); i++) {
            var wall = wall_list[| i];
            wall_hit = !wall.shoot_through;
            if(wall_hit == true){
                break;
            }
        }
        if (wall_hit == false && instance_exists(instance)) {
            instance.hp.damage(1);
            hit = true;
        }
        ds_list_destroy(wall_list);
        instance = ds_map_find_next(slash_object.collisions, instance);
    }
    if (hit == true) {
        on_hit.invoke();
    }
}
