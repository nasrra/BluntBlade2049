/// @description Insert description here
// You can write your code in this editor

event_inherited();
create_trail_particle();
trail_particle.initialise(part_type_electricity(), sprite_width, sprite_height);
trail_particle.start_stream(3);

// instance_destroy(light);
// light = obj_lighting_manager.create_light_source(x+(sprite_width/2),y+(sprite_width/2),120, make_colour_rgb(0,246,255));
light.colour = make_colour_rgb(0,246,255);
light.start_pulse_random_size(120, 20, 220, 6, 0.66);

lightning = noone;

function _emit_chain_lightning_loop(){
    lightning = instance_create_layer(x,y,LAYER_PARTICLE, obj_lightning);
    var hits = lightning.emit_chain_lightning(20, 5, 20, object_to_damage)
    for(var i = 0; i < array_length(hits); i++){
        hits[i].hp.damage(damage);
    }
    alarm_set(0, 40);
}
alarm_set(0, 40);

function _update_chain_lightning(){
    if(instance_exists(lightning) == true){
        lightning.x = x;
        lightning.y = y;
    }
}

check_collisions = function(){
    hit = undefined;    
    hit = instance_place(x,y,obj_explosive_barrel);
    if(hit != noone){
        hit.hp.damage(damage);
        instance_destroy();
    }
    if(place_meeting(x, y, obj_environment)){
        instance_destroy();
    }
}

audiomanager_play_electric_loop();