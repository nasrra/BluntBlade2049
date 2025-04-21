function part_type_fire_trail() {
    var _type = part_type_create();
    // Manually set particle properties (you'll need to define these values)
    part_type_shape(_type, pt_shape_square);  // Example: shape of the particle
    part_type_color3(_type, c_orange, c_red, c_red);  // Color
    part_type_scale(_type, 0.1, 0.1);  // Scale
    part_type_size(_type, 1.0, 1.0, -0.075, 0);  // Size range
    part_type_alpha3(_type, 1, 0.25, 0);  // Alpha values (transparency)
    part_type_speed(_type,1, 2,0,0);  // Speed range
    part_type_direction(_type, 80, 100, 0, 0);  // Direction range
    part_type_life(_type, 40, 40);  // Life span
    part_type_orientation(_type, 0, 360, -1, 0, true);
    // Return the new particle type
    return _type;
}

function part_type_parry(){
    var _type = part_type_create();

    part_type_shape(_type, pt_shape_square);  
    part_type_color3(_type, c_white, c_white, c_white);
    part_type_scale(_type, 0.075, 0.075);
    part_type_size(_type, 0.5, 1.0, -0.05, 0);
    part_type_alpha3(_type, 1, 0.5, 0);
    part_type_speed(_type,3, 6,0,0);
    part_type_direction(_type, 80, 100, 0, 0);
    part_type_orientation(_type, 0, 360, 0.075, 0.05, true);
    part_type_life(_type, 20, 30);

    return _type;
}

function part_type_explosion(){
    var _type = part_type_create();
    
    part_type_shape(_type, pt_shape_square);
    part_type_color3(_type, c_white, c_gray, c_black);
    part_type_life(_type, 60, 60);
    part_type_scale(_type, 0.25, 0.25);
    part_type_size(_type, 1.0, 2.0, -0.04, 0);
    part_type_alpha3(_type, 0.75, 0.33, 0);
    part_type_speed(_type,5, 15,-1,0);
    part_type_direction(_type, 80, 100, 0, 0);
    part_type_orientation(_type, 0, 360, 5, 5, true);

    return _type;
}

function part_type_electricity(){
    var _type = part_type_create();

    part_type_shape(_type, pt_shape_line);
    part_type_color3(_type, make_colour_rgb(0,246,255), make_colour_rgb(0,123,255), c_blue);
    part_type_life(_type, 60, 60);
    part_type_scale(_type, 0.1, 0.1);
    part_type_size(_type,  1,  1, -0.02, 1);
    part_type_alpha3(_type, 1, 0.75, 0);
    part_type_speed(_type,2, 4,-0.25,0.25);
    part_type_direction(_type, 0, 360, 0, 0);
    part_type_orientation(_type, 0, 360, 360, 10, true);

    return _type;
}