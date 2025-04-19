function particletype_fire_trail() {
    var _new_type = part_type_create();

    // Manually set particle properties (you'll need to define these values)
    part_type_shape(_new_type, pt_shape_square);  // Example: shape of the particle
    part_type_color3(_new_type, c_orange, c_red, c_red);  // Color
    part_type_scale(_new_type, 0.1, 0.1);  // Scale
    part_type_size(_new_type, 1.0, 1.0, -0.075, 0);  // Size range
    part_type_alpha3(_new_type, 1, 0.25, 0);  // Alpha values (transparency)
    part_type_speed(_new_type,5, 7,0,0);  // Speed range
    part_type_direction(_new_type, 80, 100, 0, 0);  // Direction range
    part_type_life(_new_type, 40, 40);  // Life span

    // Return the new particle type
    return _new_type;
}