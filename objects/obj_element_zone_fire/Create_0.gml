/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
element_type = ElementType.FIRE;
particles = instance_create_layer(x,y,LAYER_ENVIRONMENT,obj_particle_system);
particles.initialise(part_type_fire_trail(), sprite_width, sprite_height);
particles.start_stream(10);
light = instance_create_layer(x+(sprite_width/2),y+(sprite_width/2), LAYER_LIGHTING, obj_light);
light.initialise(100, c_orange);
light.start_pulse_random_size(100, 34, 166, 12, 0.15);