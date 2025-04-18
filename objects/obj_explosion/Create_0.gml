/// @description Insert description here
// You can write your code in this editor
part_system = part_system_create(prt_eplosion);
particle = particle_get_info(part_system).emitters[0].parttype.ind;
light = obj_lighting_manager.create_light_source(x,y,light_size,c_orange);
current_hurt_frame = 0;

function handle_hurt_frames(){
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
    part_particles_create(part_system, x, y, particle, 60);    
}

fx();
alarm_set(0, 1);
alarm_set(1, 1);
alarm_set(2, death_time);