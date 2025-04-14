/// @description Insert description here
// You can write your code in this editor

target = obj_player;
weapon_swivel_speed = 0.1;
weapon = struct_gun_shotgun();
current_move_speed = move_speed;

start_shoot_loop_alarm_index = 3;
function start_shoot_loop(){
    alarm_set(start_shoot_loop_alarm_index, irandom_range(60, 110));
}

shoot_loop_alarm_index = 0;
function shoot_loop(){
    if(can_see_target() == 1){
        weapon.shoot(id);
    }
    alarm_set(shoot_loop_alarm_index, id.weapon.fire_rate);
}

function move(){
    if(movement_path_points == undefined || movement_path_point_index >= array_length(movement_path_points)){
        exit;
    }

    var point = movement_path_points[movement_path_point_index];
    var px = point[0];
    var py = point[1];

    var avoidance = 16;
    
    var other_enemy = instance_place(px, py, obj_enemy);
    if(other_enemy != noone && other_enemy.id != id && point_distance(other_enemy.x, other_enemy.y, px, py) <= avoidance){
        exit;
    } 

    var dir = point_direction(x,y,px,py);
    var dist = point_distance(x,y,px,py);

    var movement = min(move_speed, dist);

    x+=lengthdir_x(movement, dir);
    y+=lengthdir_y(movement, dir);
    if(dist < 1.0){
        movement_path_point_index += 1;
    }
}

function set_direction_to_target(){
    if(instance_exists(target)==false){
        exit;
    }    
    direction = point_direction(x,y,target.x,target.y);
}   

function update_weapon(){
    weapon.x        = x;
    weapon.y        = y;
    weapon.angle    = calculate_weapon_angle();
}

function face_target(){
    if(direction >= 330 || direction <= 45){
        // show_debug_message("face_right");        
    }
    else if(direction >= 45 && direction <= 135){
        // show_debug_message("face_up");
    }
    else if(direction >= 135 && direction <= 225){
        // show_debug_message("face_left");
    }
    else if(direction >= 225 && direction <= 330){
        // show_debug_message("face_down");
    }
}

function calculate_weapon_angle(){
    var true_angle = weapon.angle + angle_difference(direction, weapon.angle) * weapon_swivel_speed;
    var clamped_angle = (true_angle % 360 + 360) % 360;
    return clamped_angle;
}

function draw_weapon(){
    var weapon_y_scale = (direction > 90 && direction < 270)? -1 : 1;
    var offset_x = lengthdir_x(id.weapon.offset_x, id.weapon.angle);
    var offset_y = lengthdir_y(id.weapon.offset_y, id.weapon.angle);
    draw_sprite_ext(id.weapon.sprite, 0, x + offset_x, y + offset_y, 1, weapon_y_scale, id.weapon.angle, c_white, 1); // draw weapon.
}
update_weapon();



// make it so the path stops when knocking back enemies as they are hit by bullet.
movement_path = undefined;
movement_path_points = [];
movement_path_point_index = 1;
movement_path_alarm_index = 1;
function _update_movement_path(){
    if(instance_exists(target) == false)
        exit;

    delete_movement_path();

    movement_path = path_add();

    // update target position.
    var target_y = target.y;
    var target_x = target.x;

    // assign path to use for new pathing.
    mp_grid_path(obj_enemy_path_manager.grid, movement_path, x, y, target_x, target_y, 1);

    // path algoritm to generate path to point.
    // path_start(movement_path, current_move_speed, path_action_stop, true);

    movement_path_points = [];
    var points_count = path_get_number(movement_path);
    for(var i = 0; i < points_count; i++){
        var px = path_get_point_x(movement_path,i);
        var py = path_get_point_y(movement_path,i);
        array_push(movement_path_points, [px,py]);
    }

    movement_path_point_index = 1;

    alarm_set(movement_path_alarm_index, 60);
}

function delete_movement_path(){
    if(movement_path!=undefined){
        path_delete(movement_path);
    }
}

damage_flash = new sh_damage_flash_controller(id, c_white);


function can_see_target(){
    if(instance_exists(target) == false){
        exit;
    }
    var flag = collision_line(x, y, target.x, target.y, obj_environment, true, true) == noone? true : false;
    return flag;
}

hp = new HealthPoints(health_max_value, health_max_value);
hp.on_damage.set(function(){damage_flash.invoke(0.1);});
hp.on_death.set(function(){instance_destroy();});

start_shoot_loop();
alarm_set(movement_path_alarm_index, 1);