/// @description Insert description here
// You can write your code in this editor
particles = instance_create_layer(x,y,"Bullets",obj_particle_system);
particles.initialise(part_type_explosion(), x,y);
particles.set_emission_angle(0,360);
light = obj_lighting_manager.create_light_source(x,y,light_size,c_orange);
current_hurt_frame = 0;
hit_objects = ds_map_create();

function handle_hurt_frames(){
    var hit_list = ds_list_create();
    var hits = collision_circle_list(x,y,hurt_radius, obj_enemy, false, true, hit_list, false);
    for(var i = 0; i < hits; i++){
        var enemy = ds_list_find_value(hit_list, i);
        if(ds_map_find_value(hit_objects, enemy.id) == undefined){
            enemy.hp.damage(1);
            
            // if the enemy didnt just die.
            if(instance_exists(enemy) == true){
                ds_map_add(hit_objects, enemy.id, true);
            }
        }
    }
    var hit = collision_circle(x,y,hurt_radius, obj_player, false, true);
    if(hit != noone && ds_map_find_value(hit_objects, hit.id) == undefined){
        hit.hp.damage(1);

        // if the player didnt just die.
        if(instance_exists(hit) == true){
            ds_map_add(hit_objects, hit.id, true);
        }
    }

    current_hurt_frame += 1;
    if(current_hurt_frame < hurt_frames){
        alarm_set(0, 1);
    }
}

function decay_light(){
    if(instance_exists(light)==false){
        exit;
    }
    if(light.size <= 1){
        instance_destroy(light);
    }
    else{
        light.size = lerp(light.size, 0, 0.25);
    }
    alarm_set(1,1);
}

function fx(){
    obj_camera.shake_camera(240,1,15);
    particles.emit(60);
    audiomanager_play_explosion();
}

fx();
alarm_set(0, 1);
alarm_set(1, 1);
alarm_set(2, death_time);