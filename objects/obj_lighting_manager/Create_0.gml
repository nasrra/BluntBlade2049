light_u_position = shader_get_uniform(sh_light, "u_position");
shadow_u_position = shader_get_uniform(sh_shadow, "u_position");

// creating a vertex buffer for shadows.
vertex_format_begin();

// NOTE: 
// position is only needed as shadows are always black. 
// 3D for z pos when layering lights and shadows
vertex_format_add_position_3d();

vf = vertex_format_end();
vb = vertex_create_buffer();