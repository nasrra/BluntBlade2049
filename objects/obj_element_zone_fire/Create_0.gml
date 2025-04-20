/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
element_type = ElementType.FIRE;
particles = instance_create_layer(x,y,"Environment",obj_particle_system);
particles.initialise(part_type_fire_trail(), sprite_width, sprite_height);
particles.start_stream(10);

fire_light_start_size = 100;
fire_light_target_size = 100;
fire_light_crackle_range = 66;
decrease_fire_light_size = true;
fire_light = obj_lighting_manager.create_light_source(x+(sprite_width/2),y+(sprite_width/2),fire_light_target_size , c_orange);
alarm_set(0,1);

function update_fire_light(){
    fire_light.size = lerp(fire_light.size, fire_light_target_size, 0.5);
}