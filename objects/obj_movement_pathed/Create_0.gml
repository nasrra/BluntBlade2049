/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
target = undefined;

move = function move(){
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

    var dir = point_direction(entity_id.x,entity_id.y,px,py);
    var dist = point_distance(entity_id.x,entity_id.y,px,py);

    var movement = min(max_speed, dist);

    with(entity_id){
        x+=lengthdir_x(movement, dir);
        y+=lengthdir_y(movement, dir);
    }
    if(dist < 1.0){
        movement_path_point_index += 1;
    }
}

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
    mp_grid_path(obj_enemy_path_manager.grid, movement_path, entity_id.x, entity_id.y, target_x, target_y, 1);

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
    show_debug_message(array_length(movement_path_points));
    alarm_set(movement_path_alarm_index, 60);
}

function delete_movement_path(){
    if(movement_path!=undefined){
        path_delete(movement_path);
    }
}

// start our movement pathing.
alarm_set(movement_path_alarm_index, 60);
