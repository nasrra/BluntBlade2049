/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
element_type = ElementType.ELECTRIC;
particles = instance_create_layer(x,y,LAYER_ENVIRONMENT,obj_particle_system);
particles.initialise(part_type_electric(), sprite_width, sprite_height);
particles.start_stream(3);
light = instance_create_layer(x+(sprite_width/2),y+(sprite_width/2), LAYER_LIGHTING, obj_light);
light.initialise(200, c_electric_light, 360, 0.25);
light.start_pulse_random_size(200, 80, 400, 6, 0.66);