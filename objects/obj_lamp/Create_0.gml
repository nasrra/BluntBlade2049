/// @description Insert description here
// You can write your code in this editor
light1 = instance_create_layer(x-sprite_width*0.33,y-sprite_height*0.5,LAYER_LIGHTING, obj_light);
light1.initialise(300, c_yellow, 90, 0.05);
light1.dir = 270;

light2 = instance_create_layer(x+sprite_width*0.33,y-sprite_height*0.5,LAYER_LIGHTING, obj_light);
light2.initialise(300, c_yellow, 90, 0.05);
light2.dir = 270;