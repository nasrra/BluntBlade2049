function part_type_fire_trail() {
    var _type = part_type_create();
    // Manually set particle properties (you'll need to define these values)
    part_type_shape(_type, pt_shape_square);  // Example: shape of the particle
    part_type_color3(_type, c_fire_light, c_fire, c_fire);  // Color
    part_type_alpha3(_type, 1, 0.25, 0);  // Alpha values (transparency)
    part_type_scale(_type, 0.1, 0.1);  // Scale
    part_type_size(_type, 1.0, 1.0, -0.075, 0);  // Size range
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
    part_type_alpha3(_type, 1, 0.5, 0);
    part_type_scale(_type, 0.1, 0.12);
    part_type_size(_type, 0.5, 1.0, -0.05, 0);
    part_type_speed(_type,3, 6,0,0);
    part_type_direction(_type, 80, 100, 0, 0);
    part_type_orientation(_type, 0, 360, 0.075, 0.05, true);
    part_type_life(_type, 20, 30);

    return _type;
}

function part_type_explosion_bomb(){
    var _type = part_type_create();
    
    part_type_shape(_type, pt_shape_square);
    part_type_color3(_type, c_white, c_gray, c_black);
    part_type_alpha3(_type, 0.75, 0.33, 0);
    part_type_life(_type, 60, 60);
    part_type_scale(_type, 0.25, 0.25);
    part_type_size(_type, 1.0, 2.0, -0.04, 0);
    part_type_speed(_type,5, 15,-1,0);
    part_type_direction(_type, 80, 100, 0, 0);
    part_type_orientation(_type, 0, 360, 5, 5, true);

    return _type;
}

function part_type_explosion_electric(){
    var _type = part_type_create();
    part_type_shape(_type, pt_shape_line);
    part_type_color3(_type, c_electric_light, c_electric, c_electric_dark);
    part_type_alpha3(_type, 1, 0.75, 0);
    part_type_life(_type, 60, 60);
    part_type_scale(_type, 0.25, 0.25);
    part_type_size(_type, 1.0, 2.0, -0.04, 0);
    part_type_speed(_type,10, 25,-3,0);
    part_type_direction(_type, 80, 100, 0, 0);
    part_type_orientation(_type, 0, 360, 0, 45, true);

    return _type;
}

function part_type_electric(){
    var _type = part_type_create();

    part_type_shape(_type, pt_shape_line);
    part_type_color3(_type, c_electric_light, c_electric, c_electric_dark);
    part_type_alpha3(_type, 1, 0.75, 0);
    part_type_life(_type, 60, 60);
    part_type_scale(_type, 0.1, 0.1);
    part_type_size(_type,  1,  1, -0.02, 1);
    part_type_speed(_type,2, 4,-0.25,0.25);
    part_type_direction(_type, 0, 360, 0, 0);
    part_type_orientation(_type, 0, 360, 360, 10, true);

    return _type;
}

function part_type_entity_damaged(){
    var _type = part_type_create();

    part_type_shape(_type, pt_shape_square);  
    part_type_color3(_type, c_white, c_red, c_white);
    part_type_alpha3(_type, 1, 0.5, 0);
    part_type_scale(_type, 0.125, 0.175);
    part_type_size(_type, 0.5, 1.0, -0.05, 0);
    part_type_speed(_type,4, 6,-0.25,0);
    part_type_direction(_type, 0, 360, 0, 0);
    part_type_orientation(_type, 0, 360, 0.075, 0.05, true);
    part_type_life(_type, 60, 60);

    return _type;
}

function part_type_bullet_hit(){
    var _type = part_type_create();

    part_type_shape(_type, pt_shape_square);  
    part_type_color3(_type, c_yellow, c_yellow, c_yellow);
    part_type_speed(_type,6, 8,-0.5,0);
    part_type_scale(_type, 0.1, 0.12);
    part_type_size(_type, 0.5, 1.0, -0.075, 0);
    part_type_alpha3(_type, 0.5, 0.25, 0);
    part_type_direction(_type, 80, 100, 0, 0);
    part_type_orientation(_type, 0, 360, 0.075, 0.05, true);
    part_type_life(_type, 40, 60);

    return _type;
}

function part_type_muzzle_flash(){
    var _type = part_type_create();

    part_type_shape(_type, pt_shape_square);  
    part_type_color3(_type, c_yellow, c_yellow, c_yellow);
    part_type_speed(_type,4, 10,-0.5,0);
    part_type_scale(_type, 0.1, 0.12);
    part_type_size(_type, 0.5, 1.0, -0.075, 0);
    part_type_alpha3(_type, 0.77, 0.5, 0);
    part_type_direction(_type, 80, 100, 0, 0);
    part_type_orientation(_type, 0, 360, 0.075, 0.05, true);
    part_type_life(_type, 40, 60);

    return _type;
}

function part_type_heal(){
    var _type = part_type_create();

    part_type_shape(_type, pt_shape_square);  
    part_type_color3(_type, c_green, make_colour_rgb(0,255,148), c_white);
    part_type_alpha3(_type, 1, 0.75, 0);
    part_type_scale(_type, 0.1, 0.12);
    part_type_size(_type, 1.0, 1.0, -0.02, 0.25);
    part_type_speed(_type,1.0, 3.0,-0.05,0);
    part_type_direction(_type, 0, 360, 0, 0);
    part_type_orientation(_type, 0, 360, 0, 0.0, true);
    part_type_life(_type, 40, 60);

    return _type;
}