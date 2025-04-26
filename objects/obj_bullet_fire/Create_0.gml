event_inherited();
create_particles();
particles.initialise(part_type_fire_trail(),sprite_width,sprite_height);
particles.start_stream(6);

on_hit.set(function(){
    if (variable_instance_exists(hit, "element_status")){
        hit.element_status.set_status(ElementType.FIRE);
    }
});