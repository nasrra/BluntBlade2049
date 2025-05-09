/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
element_type = ElementType.FIRE;
particles = instance_create_layer(x,y,LAYER_ENVIRONMENT,obj_particle_system);
particles.initialise(part_type_fire_trail(), sprite_width, sprite_height);
particles.start_stream(10);
light = instance_create_layer(x+(sprite_width/2),y+(sprite_width/2), LAYER_LIGHTING, obj_light);
light.initialise(150, c_fire_light, 360, 0.75);
light.start_pulse_random_size(200, 68, 332, 12, 0.15);