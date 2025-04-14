function gun_base(_sprite, _bullet_object, _offset_x, _offset_y, _length, _fire_rate, _angle) constructor{
    sprite              = _sprite       ;
    bullet_object       = _bullet_object;
    x                   = 0            ;
    y                   = 0            ;
    offset_x            = _offset_x     ;
    offset_y            = _offset_y     ;
    length              = _length       ;
    fire_rate           = _fire_rate    ;
    angle               = _angle        ;
    multi_shot_amount   = 0;
    multi_shot_spread   = 0;
    // function that should be called.
	shoot = undefined;
    play_sound = undefined;
    // functions to choose from to assign shoot to.

    function set_shoot_single(){
        shoot = function shoot_single(_id){
            var bullets = [];
            var shoot_point_x = x + lengthdir_x(length + offset_x, angle);
            var shoot_point_y = y + lengthdir_y(length + offset_y, angle);
            var bullet_instance  = instance_create_layer(shoot_point_x, shoot_point_y, "Bullets", bullet_object);
            bullet_instance.move_in_direction(angle);
            array_push(bullets, bullet_instance);
            bullet_instance.sender = _id;
            if(play_sound != undefined){
                play_sound();
            }
            return bullets;
        }
    }

    function set_shoot_multi(_amount, _spread_angle){
        multi_shot_amount = _amount;
        multi_shot_spread = _spread_angle;
        shoot = function shoot_multi(_id){
            var bullets = [];
            var shoot_point_x = x + lengthdir_x(length + offset_x, angle);
            var shoot_point_y = y + lengthdir_y(length + offset_y, angle);
            var start_angle_offset = angle - multi_shot_spread * 0.5;
            var step = multi_shot_spread / max(1,multi_shot_amount - 1);
            for(var i = 0; i<multi_shot_amount; i++){
                var angle_offset = start_angle_offset + i * step;
                var bullet_instance  = instance_create_layer(shoot_point_x, shoot_point_y, "Bullets", bullet_object);
                bullet_instance.move_in_direction(angle_offset);
                bullet_instance.sender = _id;
                array_push(bullets, bullet_instance);
            }
            if(play_sound != undefined){
                play_sound();
            }
            return bullets;
        }
    }
}

function struct_gun_revolver(){
    var base = new gun_base(
        spr_weapon_revolver,
        obj_bullet_default,
        16,
        16,
        16,
        60,
        0,
    );
    base.set_shoot_single();
    base.play_sound = audiomanager_revolver_shot;
    return base;
}

function struct_gun_shotgun(){
    var base = new gun_base(
        spr_weapon_shotgun,
        obj_bullet_default,
        16,
        16,
        16,
        120,
        0,
    );
    // base.set_shoot_single();
    base.set_shoot_multi(5, 45);
    base.play_sound = audiomanager_shotgun_shot;
    return base;
}