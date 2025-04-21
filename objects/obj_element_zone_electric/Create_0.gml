/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
element_type = ElementType.ELECTRIC;
particles = instance_create_layer(x,y,"Environment",obj_particle_system);
particles.initialise(part_type_electricity(), sprite_width, sprite_height);
particles.start_stream(3);

fire_light_start_size = 120;
fire_light_target_size = 120;
fire_light_crackle_range = 100;
decrease_fire_light_size = true;
fire_light = obj_lighting_manager.create_light_source(x+(sprite_width/2),y+(sprite_width/2),fire_light_target_size , make_colour_rgb(0,246,255));
alarm_set(0,1);

function update_fire_light(){
    fire_light.size = lerp(fire_light.size, fire_light_target_size, 0.85);
}