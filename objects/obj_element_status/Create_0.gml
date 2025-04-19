
    entity_id = undefined;
    particles = undefined;
    status = undefined;
    current_status_loop_frame = 0;

    function set_status(_element_status){
        status = _element_status;
        particles = instance_create_layer(entity_id.x,entity_id.y,entity_id.layer,obj_particle_system);
        switch(_element_status){
            case ElementType.FIRE:
                particles.initialise(particletype_fire_trail(), entity_id.sprite_width, entity_id.sprite_height);
                show_debug_message(_element_status);
                break;
        }
        particles.start_stream(5);
        start_status_loop();
    }    


function start_status_loop(){
    alarm_set(0,1);
}

function _status_loop(){
    if(current_status_loop_frame > 120){
        current_status_loop_frame = 0; 
        particles.smooth_destroy(60);
        exit;
    }
    current_status_loop_frame++;
    particles.x = entity_id.x;
    particles.y = entity_id.y;
    alarm_set(0,1);
}