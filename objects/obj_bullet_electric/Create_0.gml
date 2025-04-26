/// @description Insert description here
// You can write your code in this editor
particles = instance_create_layer(x,y,"Environment",obj_particle_system);
particles.initialise(part_type_electricity(), sprite_width, sprite_height);
particles.start_stream(3);