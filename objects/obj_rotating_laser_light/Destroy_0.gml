/// @description Insert description here
// You can write your code in this editor
for(var i = 0; i < array_length(lights); i++){
    instance_destroy(lights[i]);
}

instance_create_layer(x,y,LAYER_ENVIRONMENT,obj_element_zone_electric);