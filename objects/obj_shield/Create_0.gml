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

function parry(){
    if(parry_active == false){
        // _handle_element_status();
        parry_timer = 20;
        parry_active = true;
        // show_debug_message("parry!");
        alarm_set(parry_alarm_index, 1);
    }
}

function _check_collisions(){
    var collisions = ds_list_create();
    var parried = false;
    instance_place_list(x, y, obj_bullet, collisions, false);

    // if we successfully parry a bullet.
    if (ds_list_size(collisions) > 0) {
        if(parry_active == true){
            for(var i = 0; i < ds_list_size(collisions); i++){
                var instance = ds_list_find_value(collisions, i);
                if(instance.sender != id){
                    instance.send_back_to_sender();
                    instance.set_object_to_damage(obj_enemy);
                    parried = true;
                }
            }
            if(parried == true){
                audiomanager_play_parry();
                obj_camera.shake_camera(44, 1, 12);
				parry_particle.x = x;
				parry_particle.y = y;
                parry_particle.set_emission_angle(image_angle-45, image_angle+45);
                parry_particle.emit(15);
                parry_hit = true;
                on_parry.invoke();
            }
        }
        else{
            for(var i = 0; i < ds_list_size(collisions); i++){
                // destroy any bullets we ahve come into contact with.
                instance_destroy(collisions[| i]);
            }
        }
    }
    ds_list_destroy(collisions);
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
    // show_debug_message("finished parry!");        
}