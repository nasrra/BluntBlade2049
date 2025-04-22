on_status_set = new EventAction();
on_clear_status = new EventAction();
entity_id = undefined;
particles = noone;
particle_offset_x = 0;
particle_offset_y = 0;
status = undefined;
current_status_loop_frame = 0;

function initialise(_entity_id){
    entity_id = _entity_id;
}

function set_status(_element_status){
    status = _element_status;
    if(instance_exists(particles) == true){
        particles.smooth_destroy(60);
    }
    particles = instance_create_layer(entity_id.x,entity_id.y,entity_id.layer,obj_particle_system);
    switch(_element_status){
        case ElementType.FIRE:
            particles.initialise(part_type_fire_trail(), entity_id.sprite_width, entity_id.sprite_height);
            break;
        case ElementType.ELECTRIC:
            particles.initialise(part_type_electricity(), entity_id.sprite_width, entity_id.sprite_height);
            break;

    }
    particles.start_stream(5);
    start_status_loop();
    on_status_set.invoke();
}    


function start_status_loop(){
    current_status_loop_frame = 0; 
    alarm_set(0,1);
}

function _status_loop(){
    if(current_status_loop_frame > 360){
        clear_status();
        exit;
    }
    current_status_loop_frame++;
    particles.x = entity_id.x + particle_offset_x;
    particles.y = entity_id.y + particle_offset_y;
    alarm_set(0,1);
}

function clear_status(){
    status = undefined;
    stop_status_loop();
    on_clear_status.invoke();
}

function stop_status_loop(){
    particles.smooth_destroy(60);
    alarm_set(0,0);
}

function emit_chain_lightning(_segment_length, _points_per_segment, _time_in_frames, _obj_to_hit){
    var start_x = x;
	var start_y = y;
    var current_instance = entity_id;
	var all_hits = ds_map_create();
    while(true){
        var current_hits = ds_list_create();
        var hit = false;
        collision_circle_list(start_x, start_y, 240, _obj_to_hit, false, true, current_hits, true);
        if(ds_list_size(current_hits) <= 0){
            show_debug_message("false");
            exit;      
        }
        for(var i = 0; i < ds_list_size(current_hits); i++){
            show_debug_message(i);
            var instance = ds_list_find_value(current_hits,i);
            if(ds_map_find_value(all_hits, instance.id) != undefined){
                continue;
            }
            hit = true;
		    var lightning_instance = instance_create_layer(start_x, start_y, "Particles", obj_lightning);
            lightning_instance.initialise(current_instance, 4,-10,10);
            lightning_instance.emit_to_instance(_segment_length, _points_per_segment, instance, _time_in_frames);    
            start_x = instance.x;
            start_y = instance.y;
            current_instance = instance;
            ds_map_add(all_hits, instance.id, true);
        }
        ds_list_destroy(current_hits);
        if(hit == false){
            exit;
        }
    }
    ds_list_destroy(current_hits);
    ds_map_destroy(all_hits);
}
