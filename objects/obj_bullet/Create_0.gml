/// @description Insert description here
// You can write your code in this editor
direction = point_direction(0,0,0,0);

hit = noone;
on_hit = new EventAction();

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
    speed *= 2;
}

function set_object_to_damage(_object){
    object_to_damage = _object;
}

function check_collisions(){
    hit = noone;    
    hit = instance_place(x,y,obj_dyn_environment);
    if(hit != noone){
        if(variable_instance_exists(hit, "hp")==true){
            hit.hp.damage(damage);
        }
        on_hit.invoke();
        instance_destroy();
    }
    hit = instance_place(x,y,object_to_damage);
    if(hit != noone){
        hit.hp.damage(damage);
        on_hit.invoke();
        instance_destroy();
    }
    hit = instance_place(x,y,obj_environment);
    if(hit != noone && hit.shoot_through == false){
        instance_destroy();
    }
}

light = instance_create_layer(x+(sprite_width/2),y+(sprite_height/2),LAYER_LIGHTING, obj_light);
light.initialise(light_size,c_yellow, 360, 1);

function update_light(){
    if(instance_exists(light)){
        light.x = x+(sprite_width/2);
        light.y = y+(sprite_height/2);
    }
}

trail_particle = noone;
function create_trail_particle(){
    trail_particle = instance_create_layer(x+(sprite_width/2),y+(sprite_width/2),LAYER_BULLET,obj_particle_system);
}

function update_particles(){
    if(instance_exists(trail_particle) == true){
        trail_particle.x = x;
        trail_particle.y = y;
    }
}

function set_trail_particle_direction(){
    if(instance_exists(trail_particle) == true){
        trail_particle.set_emission_angle(((direction+180) % 360) - 20, ((direction+180) % 360) + 20);
    }
}

function _spawn_hit_particle(){
    var hit_particle = instance_create_layer(x+(sprite_width/2),y+(sprite_width/2),LAYER_BULLET, obj_particle_system);
    var dir = (direction+180) % 360; //opposite of direction;
    hit_particle.initialise(part_type_bullet_hit(),0,0);
    hit_particle.set_emission_angle(dir-20, dir+20);
    hit_particle.emit_one_shot(12,60);
}