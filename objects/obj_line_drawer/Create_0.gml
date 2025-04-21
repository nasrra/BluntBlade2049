/// @description Create
// You can write your code in this editor
noise_min           = undefined;
noise_max           = undefined;
end_x               = undefined;
end_y               = undefined;
segment_length      = undefined;
points_per_segment  = undefined;
max_time_in_frames  = undefined;
current_frame       = undefined;
line_width          = undefined;

lines_to_draw = [];
point_offsets = [];

function initialise(_line_width,_noise_min, _noise_max){
    line_width = _line_width;
    noise_min = _noise_min;
    noise_max = _noise_max;
}

function draw_segmented(_segment_length, _points_per_segment, _end_x, _end_y, _time_in_frames){
    segment_length      = _segment_length;
    points_per_segment  = _points_per_segment;
    end_x               = _end_x;
    end_y               = _end_y;
    max_time_in_frames  = _time_in_frames;
    current_frame       = 0;
    // _set_point_offsets();
    alarm_set(0,1);
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

function _segmented_loop(){
    _set_point_offsets();
    lines_to_draw = [];

    var dx = end_x - x;
    var dy = end_y - y;
    var length = point_distance(x, y, end_x, end_y);
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

    while (current_distance < 1) {
        var next_distance = current_distance + distance_factor;

        var x1 = x + dx * current_distance;
        var y1 = y + dy * current_distance;
        var x2 = x + dx * next_distance;
        var y2 = y + dy * next_distance;

        var offset1 = point_offsets[iteration];
        var offset2 = point_offsets[iteration + 1];

        // Offset both points perpendicular to line direction
        x1 += perp_x * offset1;
        y1 += perp_y * offset1;
        x2 += perp_x * offset2;
        y2 += perp_y * offset2;

        array_push(lines_to_draw, [x1, y1, x2, y2]);

        current_distance = next_distance;
        iteration++;
    }

    if (current_frame >= max_time_in_frames) {
        exit;
    }

    current_frame++;
    alarm_set(0, 1);
}
