/// @description Create
// You can write your code in this editor
on_emission_finish  = new EventAction();
noise_min           = undefined;
noise_max           = undefined;
end_x               = undefined;
end_y               = undefined;
end_object_id       = undefined;
segment_length      = undefined;
points_per_segment  = undefined;
max_time_in_frames  = undefined;
current_frame       = undefined;
line_width          = undefined;
entity_id           = id;

lines_to_draw = [];
point_offsets = [];
lights = [];
colour = make_colour_rgb(0,246,255);

function initialise(_entity_id, _line_width,_noise_min, _noise_max){
    line_width = _line_width;
    noise_min = _noise_min;
    noise_max = _noise_max;
    entity_id = _entity_id;
}

function emit_to_point(_segment_length, _points_per_segment, _end_x, _end_y, _time_in_frames){
    segment_length      = _segment_length;
    points_per_segment  = _points_per_segment;
    end_x               = _end_x;
    end_y               = _end_y;
    max_time_in_frames  = _time_in_frames;
    current_frame       = 0;
    // _set_point_offsets();
    alarm_set(0,1);
}

function emit_to_instance(_segment_length, _points_per_segment, _end_object_id, _time_in_frames){
    segment_length      = _segment_length;
    points_per_segment  = _points_per_segment;
    max_time_in_frames  = _time_in_frames;
    current_frame       = 0;
    end_object_id       = _end_object_id;
    end_x               = end_object_id.x;
    end_y               = end_object_id.y;
    alarm_set(1,1);
}

function _set_point_offsets(){
    // first point has no noise offset.
    point_offsets = [];
    var length = point_distance(x, y, end_x, end_y);
    var total_points = floor(length * points_per_segment / segment_length);
    array_push(point_offsets, 0);

    for(var i = 1; i < total_points; i++){
        array_push(point_offsets,random_range(noise_min, noise_max));
    }

    // last point has no noise offset.
    array_push(point_offsets, 0);
}

function update_position(){
    x = entity_id.x;
    y = entity_id.y;
}

function _segmented_loop_to_point(){
    _segmented_loop(end_x, end_y, 0);
}

function _segmented_loop_to_object(){
    _segmented_loop(end_object_id.x, end_object_id.y, 1);
}

function _segmented_loop(_end_x, _end_y, _alarm_index){
    _set_point_offsets();
    lines_to_draw = [];

    var dx = _end_x - x;
    var dy = _end_y - y;
    var length = point_distance(x, y, _end_x, _end_y);
    var total_points = floor(length * points_per_segment / segment_length);
    var distance_factor = 1 / (total_points + 1);
    var current_distance = distance_factor;

    var iteration = 0;

    // Normalize direction vector
    var dir_x = dx / length;
    var dir_y = dy / length;

    // Perpendicular vector (for nice visual wiggle)
    var perp_x = -dir_y;
    var perp_y = dir_x;

    _clear_lights();
    while (current_distance < 1) {
        var next_distance = current_distance + distance_factor;

        var x1 = x + dx * current_distance;
        var y1 = y + dy * current_distance;
        var x2 = x + dx * next_distance;
        var y2 = y + dy * next_distance;

        var offset1 = 0;
        var offset2 = 0;
        if(iteration < array_length(point_offsets)-1){
            var offset1 = point_offsets[iteration];
        }
        if(iteration < array_length(point_offsets)-1){
            var offset2 = point_offsets[iteration + 1];
        }

        // Offset both points perpendicular to line direction
        x1 += perp_x * offset1;
        y1 += perp_y * offset1;
        x2 += perp_x * offset2;
        y2 += perp_y * offset2;

        array_push(lines_to_draw, [x1, y1, x2, y2]);
        
        _create_light(x1,y1,x2,y2);

        current_distance = next_distance;
        iteration++;
    }

    if (current_frame >= max_time_in_frames) {
        on_emission_finish.invoke();
        instance_destroy();
        _clear_lights();
        exit;
    }

    current_frame++;
    alarm_set(_alarm_index, 1);
}

function _clear_lights(){
    for(var i = 0; i < array_length(lights); i++){
        instance_destroy(lights[i]);
    }
}

function _create_light(_x1,_y1,_x2,_y2){
    var dir = point_direction(_x1,_y1,_x2,_y2);
    var light = instance_create_layer(_x1,_y1,"Lighting",obj_light);
    light.colour = colour;
    light.fov = 15;
    light.size = 0.001;
    light.strength = 10;
    light.dir = dir;
    array_push(lights, light);
}
