/// @description Insert description here
// You can write your code in this editor
max_size = 30;
target_size = max_size;
ambient_light = obj_lighting_manager.create_light_source(x+8,y+8,max_size,c_orange);
hp = new HealthPoints(1,1);
alarm_set(0, 1);

function explode(){
    instance_create_layer(x+8,y+8,"Environment",obj_explosion);
    instance_destroy(ambient_light);
    instance_destroy();
}

hp.on_death.set(function(){
    explode();
});