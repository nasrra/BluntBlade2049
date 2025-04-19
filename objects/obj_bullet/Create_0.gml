/// @description Insert description here
// You can write your code in this editor
direction = point_direction(0,0,0,0);

// whom this bullet was sent from.
sender = undefined;
object_to_damage = obj_player;

function move_in_direction(_move_dir){
    direction = _move_dir;
    set_trail_particle_direction();
}

function move_to_object(_object){
    if(instance_exists(_object) == true){
        direction = point_direction(x,y,_object.x, _object.y);
    }
    else{
        // go the opposite direction
        direction = (direction+180) % 360; //<-- clamp into 360 degrees
    }
}

function move(){
    x += lengthdir_x(speed, direction);
    y += lengthdir_y(speed, direction);
    update_light();
}

function send_back_to_sender(){
    move_to_object(sender);
    light.colour = c_white;
}

function set_object_to_damage(_object){
    object_to_damage = _object;
}

function check_collisions(){
    var hit = undefined;    
    hit = instance_place(x,y,obj_explosive_barrel);
    if(hit != noone){
        hit.hp.damage(damage);
        instance_destroy();
    }
    hit = instance_place(x,y,object_to_damage);
    if(hit != noone){
        hit.hp.damage(damage);
        instance_destroy();
    }
    if(place_meeting(x, y, obj_environment)){
        instance_destroy();
    }
}


light = undefined;
function create_light(){
    light = obj_lighting_manager.create_light_source(x+(sprite_width/2),y+(sprite_height/2),light_size,c_yellow);
}

create_light();

function update_light(){
    if(instance_exists(light)){
        light.x = x+(sprite_width/2);
        light.y = y+(sprite_height/2);
    }
}

// part_system = part_system_create(prt_parry);
// particle = particle_get_info(prt_parry).emitters[0].parttype.ind;
trail_part_system = undefined;
trail_particle = undefined;
trail_emitter = undefined;


function set_trail_particles(_particle_type){
    trail_part_system = part_system_create();
    trail_particle = _particle_type;
    trail_emitter = part_emitter_create(trail_part_system);
    part_emitter_stream(trail_part_system, trail_emitter, trail_particle, 3);
}

function emit_trail_particles(){
    with(id){
        if(trail_part_system == undefined){
            exit;    
        }
        part_emitter_region(trail_part_system, trail_emitter, x, x+sprite_width, y+sprite_height,y, ps_shape_ellipse, ps_distr_linear);
    }
}

function set_trail_particle_direction(){
    with(id){
        if(trail_part_system != undefined){
            // particle_system_orientation(trail_part_system, image_angle, ((direction+180) % 360));
            part_type_direction(trail_particle, ((direction+180) % 360) - 20, ((direction+180) % 360) + 20, 0, 0);
        }
    }
}