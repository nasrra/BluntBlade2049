/// @description Insert description here
// You can write your code in this editor
current_hurt_frame = 0;
hit_objects = ds_map_create();

light       = noone; 
light_size  = undefined;
hurt_radius = undefined;
hurt_frames = undefined;
death_time  = undefined;
part_type   = undefined;
colour      = undefined;
audio       = undefined;
light_strength = undefined;

function handle_hurt_frames(){
    check_hits(obj_dyn_entity);
    check_hits(obj_dyn_environment);

    current_hurt_frame += 1;
    if(current_hurt_frame < hurt_frames){
        alarm_set(0, 1);
    }
}

function check_hits(_obj_to_hit){
    var hit_list = ds_list_create();
    var hits = collision_circle_list(x,y,hurt_radius, _obj_to_hit, false, true, hit_list, false);
    for(var i = 0; i < hits; i++){
        var entity = ds_list_find_value(hit_list, i);
        if(ds_exists(hit_objects, ds_type_map) == false){
            continue;
        }
        if(ds_map_find_value(hit_objects, entity.id) == undefined){
            entity.hp.damage(1);
                        
            // if the enemy didnt just die.
            if(instance_exists(entity) == true){
                ds_map_add(hit_objects, entity.id, true);
            }
        }
    }
    ds_list_destroy(hit_list);
}

function decay_light(){
    if(instance_exists(light)==false){
        exit;
    }
    if(light.size <= 1){
        instance_destroy(light);
    }
    else{
        light.size = lerp(light.size, 0, 0.33);
    }
    alarm_set(1,1);
}

function fx(){
    obj_camera.shake_camera(240,1,15);
    particles.emit(60);
    audio();
}

function initialise(){
	particles = instance_create_layer(x,y,LAYER_BULLET,obj_particle_system);
	particles.initialise(part_type, x,y);
	particles.set_emission_angle(0,360);
	light = instance_create_layer(x,y,LAYER_LIGHTING, obj_light);
	show_debug_message(string_join(" ","EXPLOSION: ",light_strength));
    light.initialise(light_size, colour, 360, light_strength);
	light.strength = light_strength;
    fx();
    alarm_set(0, 1);
    alarm_set(1, 1);
    alarm_set(2, death_time);
}