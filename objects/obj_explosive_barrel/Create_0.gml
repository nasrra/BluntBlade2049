/// @description Insert description here
// You can write your code in this editor
light = obj_lighting_manager.create_light_source(x+8,y+8,30,c_orange);
light.start_pulse_size(0,30, 30,0.33);

hp = instance_create_layer(0,0,"Environment",obj_health);
hp.initialise(1,1);
alarm_set(0, 1);

function explode(){
    instance_create_layer(x+8,y+8,"Environment",obj_explosion);
    instance_create_layer(x+8,y+8,"Environment",obj_element_zone_fire);
    instance_destroy();
}

hp.on_death.set(function(){
    explode();
});