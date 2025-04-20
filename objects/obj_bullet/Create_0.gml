/// @description Insert description here
// You can write your code in this editor
direction = point_direction(0,0,0,0);

// whom this bullet was sent from.
sender = noone;
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


light = obj_lighting_manager.create_light_source(x+(sprite_width/2),y+(sprite_height/2),light_size,c_yellow);

function update_light(){
    if(instance_exists(light)){
        light.x = x+(sprite_width/2);
        light.y = y+(sprite_height/2);
    }
}

particles = noone;
function create_particles(){
    particles = instance_create_layer(x+(sprite_width/2),y+(sprite_width/2),"Bullets",obj_particle_system);
}

function update_particles(){
    if(instance_exists(particles) == true){
        particles.x = x;
        particles.y = y;
    }
}

function set_trail_particle_direction(){
    if(instance_exists(particles) == true){
        particles.set_emission_angle(((direction+180) % 360) - 20, ((direction+180) % 360) + 20);
    }
}