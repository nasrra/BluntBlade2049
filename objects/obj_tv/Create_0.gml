/// @description Insert description here
// You can write your code in this editor
light = instance_create_layer(x,y-sprite_height*0.4,LAYER_LIGHTING, obj_light);
light.initialise(light_size, c_white, 170, light_strength);
light.dir = 270;