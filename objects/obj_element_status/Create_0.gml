
entity_id = undefined;
particles = undefined;
particle_offset_x = 0;
particle_offset_y = 0;
status = undefined;
current_status_loop_frame = 0;

function set_status(_element_status){
    status = _element_status;
    if(instance_exists(particles) == true){
        particles.smooth_destroy(60);
    }
    particles = instance_create_layer(entity_id.x,entity_id.y,entity_id.layer,obj_particle_system);
    switch(_element_status){
        case ElementType.FIRE:
            particles.initialise(part_type_fire_trail(), entity_id.sprite_width, entity_id.sprite_height);
            show_debug_message(_element_status);
            break;
    }
    particles.start_stream(5);
    start_status_loop();
}    


function start_status_loop(){
    current_status_loop_frame = 0; 
    alarm_set(0,1);
}

function _status_loop(){
    if(current_status_loop_frame > 120){
        particles.smooth_destroy(60);
        exit;
    }
    current_status_loop_frame++;
    particles.x = entity_id.x + particle_offset_x;
    particles.y = entity_id.y + particle_offset_y;
    alarm_set(0,1);
}