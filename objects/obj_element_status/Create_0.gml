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
            particles.initialise(part_type_electric(), entity_id.sprite_width, entity_id.sprite_height);
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
    if(status == undefined){
        exit;
    }
    status = undefined;
    stop_status_loop();
    on_clear_status.invoke();
}

function stop_status_loop(){
    particles.smooth_destroy(60);
    alarm_set(0,0);
}