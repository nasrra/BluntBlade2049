function BaseGun(_holder_id, _sprite, _bullet_object, _offset_x, _offset_y, _length, _fire_rate, _shoot_alarm_index) constructor{
    holder_id               = _holder_id    ;
    sprite                  = _sprite       ;
    bullet_object           = _bullet_object;
    x                       = 0            ;
    y                       = 0            ;
    offset_x                = _offset_x     ;
    offset_y                = _offset_y     ;
    length                  = _length       ;
    fire_rate               = _fire_rate    ;
    direction               = undefined;
    angle                   = 0             ;
    swivel_speed            = 1;
    shoot_loop_alarm_index  = _shoot_alarm_index;
    can_shoot               = true          ;
    flash_light             = noone;
    
    // function that should be called.
	shoot = undefined;
    play_sound = undefined;
    // functions to choose from to assign shoot to.


    function start_shoot_loop(){
        var _index = shoot_loop_alarm_index;
        with(holder_id){
            alarm_set(_index, irandom_range(60, 110));
        }
    }

    function shoot_loop(){
        // show_debug_message("shoot!");
        if(can_shoot == true){
            shoot(holder_id);
        }
        var _index = shoot_loop_alarm_index;
        var _fire_rate = fire_rate;
        with(holder_id){
            alarm_set(_index, _fire_rate);
        }
    }

    function set_position(_x,_y){
        x = _x;
        y = _y;
    }

    function point_in_direction(_direction){
        direction = _direction;
    }

    function update_angle(){
        var new_angle = angle + angle_difference(direction, angle) * swivel_speed;
        if(new_angle >= 360){
            new_angle -= 360;
        }
        if(new_angle <= 0){
            new_angle += 360;
        }
        angle = new_angle;
    }

    function draw(){
        var weapon_y_scale = (direction > 90 && direction < 270)? -1 : 1;
        var angled_offset_x = lengthdir_x(offset_x, angle);
        var angled_offset_y = lengthdir_y(offset_y, angle);
        draw_sprite_ext(sprite, 0, x + angled_offset_x, y + angled_offset_y, 1, weapon_y_scale, angle, c_white, 1); // draw weapon.
        if(instance_exists(flash_light) == true){
            flash_light.x = x+lengthdir_x(offset_x+length, angle);;
            flash_light.y = y+lengthdir_y(offset_y+length, angle);;
        }
    }

    function spawn_muzzle_flash(_x,_y,_angle){
        flash_light = instance_create_layer(_x,_y,LAYER_LIGHTING,obj_light);
        flash_light.initialise(14.5, c_yellow, 145);
        flash_light.dir = _angle;
        flash_light.timed_destroy(6);
        var particles = instance_create_layer(_x,_y,LAYER_PARTICLE, obj_particle_system);
        particles.initialise(part_type_muzzle_flash(), 0, 0);
        particles.set_emission_angle(angle-45, angle+45);
        particles.emit_one_shot(15, 60);
    }
}

function GunSingleShot(_holder_id, _sprite, _bullet_object, _offset_x, _offset_y, _length, _fire_rate, _shoot_alarm_index){
    var base = new BaseGun(_holder_id, _sprite, _bullet_object, _offset_x, _offset_y, _length, _fire_rate, _shoot_alarm_index);
    with(base){
        shoot = function shoot(){
            var bullets = [];
            var shoot_point_x = x + lengthdir_x(length + offset_x, angle);
            var shoot_point_y = y + lengthdir_y(length + offset_y, angle);
            var bullet_instance  = instance_create_layer(shoot_point_x, shoot_point_y, LAYER_BULLET, bullet_object);
            bullet_instance.move_in_direction(angle);
            array_push(bullets, bullet_instance);
            bullet_instance.sender = holder_id;
            spawn_muzzle_flash(shoot_point_x,shoot_point_y,angle);
            if(play_sound != undefined){
                play_sound();
            }
            return bullets;
        }
    }
    return base;
}

function GunSpreadShot(_holder_id,_sprite, _bullet_object, _offset_x, _offset_y, _length, _fire_rate,_shoot_alarm_index, _shot_amount, _shot_spread){
    var base = new BaseGun(_holder_id,_sprite, _bullet_object, _offset_x, _offset_y, _length, _fire_rate, _shoot_alarm_index);    
    with(base){
        spread_shot_amount      = _shot_amount;
        spread_shot_spread      = _shot_spread;
        shoot = function shoot(){
            var bullets = [];
            var shoot_point_x = x + lengthdir_x(length + offset_x, angle);
            var shoot_point_y = y + lengthdir_y(length + offset_y, angle);
            var start_angle_offset = angle - spread_shot_spread * 0.5;
            var step = spread_shot_spread / max(1,spread_shot_amount - 1);
            spawn_muzzle_flash(shoot_point_x,shoot_point_y,angle);
            for(var i = 0; i<spread_shot_amount; i++){
                var angle_offset = start_angle_offset + i * step;
                var bullet_instance  = instance_create_layer(shoot_point_x, shoot_point_y, LAYER_BULLET, bullet_object);
                bullet_instance.move_in_direction(angle_offset);
                bullet_instance.sender = holder_id;
                array_push(bullets, bullet_instance);
            }
            if(play_sound != undefined){
                play_sound();
            }
            return bullets;
        }
    }
    return base;
}

function GunBurstShot(_holder_id, _sprite, _bullet_object, _offset_x, _offset_y, _length, _fire_rate, _shoot_alarm_index, _burst_fire_rate, _burst_amount){
    var base = new BaseGun(_holder_id,_sprite, _bullet_object, _offset_x, _offset_y, _length, _fire_rate, _shoot_alarm_index);
    with(base){
        burst_fire_rate = _burst_fire_rate;
        is_shooting = false; 
        burst_amount = _burst_amount;
        current_burst_shot = 0;
        shoot = function shoot(){
            var bullets = [];
            var shoot_point_x = x + lengthdir_x(length + offset_x, angle);
            var shoot_point_y = y + lengthdir_y(length + offset_y, angle);
            var bullet_instance  = instance_create_layer(shoot_point_x, shoot_point_y, LAYER_BULLET, bullet_object);
            bullet_instance.move_in_direction(angle);
            array_push(bullets, bullet_instance);
            bullet_instance.sender = holder_id;
            spawn_muzzle_flash(shoot_point_x,shoot_point_y,angle);
            if(play_sound != undefined){
                play_sound();
            }
            return bullets;
        }
        shoot_loop = function shoot_loop(){
            var _fire_rate = undefined;
            var _index = shoot_loop_alarm_index;
            if(can_shoot == true){
                shoot(holder_id);
                if(current_burst_shot < burst_amount){
                    _fire_rate = burst_fire_rate;
                    current_burst_shot++;
                    is_shooting = true;
                }
                else{
                    is_shooting = false;
                    _fire_rate = fire_rate;
                    current_burst_shot = 0;
                }
            }
            else{
                _fire_rate = fire_rate;
            }
            with(holder_id){
                alarm_set(_index, _fire_rate);
            }
        }

    }
    return base;
}

function GunRevolver(_holder_id, _shoot_alarm_index){
    var base = GunSingleShot(
        _holder_id,
        spr_weapon_revolver,
        obj_bullet_default,
        16,
        16,
        16,
        100,
        _shoot_alarm_index
    );
    base.play_sound = audiomanager_play_revolver_shot;
    return base;
}

function GunShotgun(_holder_id, _shoot_alarm_index){
    var base = GunSpreadShot(
        _holder_id,
        spr_weapon_shotgun,
        obj_bullet_default,
        16,
        16,
        16,
        150,
        _shoot_alarm_index,
        5,
        45
    );
    base.play_sound = audiomanager_play_shotgun_shot;
    return base;
}

function GunBurstRifle(_holder_id, _shoot_alarm_index){
    var base = GunBurstShot(
        _holder_id,
        spr_weapon_burst_rifle,
        obj_bullet_default,
        16,
        16,
        16,
        150,
        _shoot_alarm_index,
        20,
        6
    );
    base.play_sound = audiomanager_play_burst_rifle_shot;
    return base;
}

function GunGrenadeLauncher(_holder_id, _shoot_alarm_index){
    var base = GunSingleShot(
        _holder_id,
        spr_weapon_grenade_launcher,
        obj_bullet_explosive,
        20,
        20,
        26,
        200,
        _shoot_alarm_index,
    );
    base.play_sound = audiomanager_play_burst_rifle_shot;
    return base;
}

function GunElementFire(_holder_id, _shoot_alarm_index){
    var base = GunSpreadShot(
        _holder_id,
        undefined,
        obj_bullet_fire,
        16,
        16,
        10,
        0,
        _shoot_alarm_index,
        3,
        90
    );
    base.play_sound = audiomanager_play_parry_element_fire;
    return base;
}

function GunElementElectric(_holder_id, _shoot_alarm_index){
    var base = GunSingleShot(
        _holder_id,
        undefined,
        obj_bullet_electric,
        16,
        16,
        10,
        0,
        _shoot_alarm_index,
        3,
        90
    );
    base.play_sound = audiomanager_play_parry_element_fire;
    return base;
}