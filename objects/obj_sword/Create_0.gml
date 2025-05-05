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
slash_object = noone;
entity_id = undefined;
element_type = ElementType.NONE;
max_element_charges = 3;
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
        _handle_element_type();
        with(slash_object){
            on_hit_bullet = new EventAction();
            on_hit_enemy = new EventAction();
        }
        slash_object.on_hit_bullet.set(function(){
            var hit = false;
            if(slash_object.collisions == undefined || ds_exists(slash_object.collisions, ds_type_map) == false){
                exit;
            }
            var instance = ds_map_find_first(slash_object.collisions);
            while(instance != undefined && instance_exists(instance) == true){
                if(instance.sender != entity_id){
                    if(collision_line(entity_id.x, entity_id.y, instance.x, instance.y, obj_environment, true, true) == noone){
                        instance.send_back_to_sender();
                        instance.set_object_to_damage(obj_enemy);
                        instance.sender = entity_id;
                        parried = true;
                        hit = true;
                    }
                }
                instance = ds_map_find_next(slash_object.collisions, instance);
            }
            if(hit == true){
                audiomanager_play_parry();
                parry_particle.x = x;
                parry_particle.y = y;
                parry_particle.set_emission_angle(image_angle-45, image_angle+45);
                parry_particle.emit(10);
                parry_particle.set_emission_angle(image_angle-45-180, image_angle+45-180);
                parry_particle.emit(10);
                parry_hit = true;
                on_parry.invoke();
            }
        });
        slash_object.on_hit_enemy.set(function(){
            var hit = false;
            if(slash_object.collisions == undefined || ds_exists(slash_object.collisions, ds_type_map) == false){
                exit;
            }
            var instance = ds_map_find_first(slash_object.collisions);
            while(instance != undefined){
                if(collision_line(entity_id.x, entity_id.y, instance.x, instance.y, obj_environment, true, true) == noone){
                    if(is_string(instance) == false && instance_exists(instance) == true){
                        hit = true; 
                        instance.hp.damage(1);
                    }
                }
                instance = ds_map_find_next(slash_object.collisions, instance);
            }
            if(hit== true){
                audiomanager_play_sword_hit();
                on_hit.invoke();
            }
        });
        audiomanager_play_sword_swing();
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
    }
}