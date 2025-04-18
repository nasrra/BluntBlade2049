// set the light resolution to be the view port resolution of the game.
// done for better performance, and to make it look crunchy.
// surface_resize(application_surface, 960,540);
// display_set_gui_maximize();

light_u_position = shader_get_uniform(sh_light, "u_position");
shadow_u_position = shader_get_uniform(sh_shadow, "u_position");
light_u_size = shader_get_uniform(sh_light, "u_size");

// surface to draw the lighting to, low resolution for performance and crunshy look.
lighting_surface = surface_create(960, 540);
scale_factor = 0.5; // 0.5 because 960x540 is half of 1080p.

// creating a vertex buffer for shadows.
vertex_format_begin();

// NOTE: 
// position is only needed as shadows are always black. 
// 3D for z pos when layering lights and shadows
vertex_format_add_position_3d();

vf = vertex_format_end();
vb = vertex_create_buffer();


function create_light_source(_x,_y,_size,_colour){
    var instance = instance_create_layer(_x,_y,"Lighting",obj_light);
    instance.size = _size;
    instance.colour = _colour;
    return instance;
}