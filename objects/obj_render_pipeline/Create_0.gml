/// @description Insert description here
// You can write your code in this editor
// surface variable.
crt_surface =  surface_create(1920, 1080);

// handle
surface_width = shader_get_uniform(sh_crt, "surface_width");
surface_height = shader_get_uniform(sh_crt, "surface_height");

function draw_application_surface_crt_lines(){
    surface_copy(crt_surface, 0,0,application_surface);

    shader_set(sh_crt);

    shader_set_uniform_f(
        surface_width,
        surface_get_width(crt_surface)
    );
    shader_set_uniform_f(
        surface_height,
        surface_get_height(crt_surface)
    );
    draw_surface(crt_surface,camera_get_view_x(0),camera_get_view_y(0));
    // draw_surface_ext(crt_surface, camera_get_view_x(0), camera_get_view_y(0), 0.5, 0.5, 0, c_white, 1);
    shader_reset();
}
