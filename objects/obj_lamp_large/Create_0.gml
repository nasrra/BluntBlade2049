/// @description Insert description here
// You can write your code in this editor
light = instance_create_layer(x,y,LAYER_LIGHTING,obj_light);
light.initialise(300, light_colour, 166, 0.75);
light.dir = 270;