/// @description Insert description here
// You can write your code in this editor
light = instance_create_layer(x+8,y+8,LAYER_LIGHTING,obj_light);
light.initialise(30, c_orange, 360);
// _size_min, _size_max, _size_frame_change, _size_lerp_speed
light.start_pulse_size(0,30, 30,0.33);

hp = instance_create_layer(0,0,LAYER_ENVIRONMENT,obj_health);
hp.initialise(1,1);
alarm_set(0, 1);

function explode(){
    instance_create_layer(x+8,y+8,LAYER_ENVIRONMENT,obj_explosion_bomb);
    instance_create_layer(x+8,y+8,LAYER_ENVIRONMENT,obj_element_zone_fire);
    instance_destroy();
}

hp.on_death.set(function(){
    explode();
});