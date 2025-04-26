/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
element_type = ElementType.ELECTRIC;
particles = instance_create_layer(x,y,LAYER_ENVIRONMENT,obj_particle_system);
particles.initialise(part_type_electricity(), sprite_width, sprite_height);
particles.start_stream(3);
light = instance_create_layer(x+(sprite_width/2),y+(sprite_width/2), LAYER_LIGHTING, obj_light);
light.initialise(120, make_colour_rgb(0,246,255));
light.start_pulse_random_size(120, 20, 220, 6, 0.66);