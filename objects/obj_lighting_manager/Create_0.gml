// set the light resolution to be the view port resolution of the game.
// done for better performance, and to make it look crunchy.
// surface_resize(application_surface, 960,540);
// display_set_gui_maximize();

application_surface_draw_enable(false);

light_u_position = shader_get_uniform(sh_light, "u_position");
shadow_u_position = shader_get_uniform(sh_shadow, "u_position");
shadow_u_cam_pos = shader_get_uniform(sh_shadow, "u_cam_pos");
light_u_size = shader_get_uniform(sh_light, "u_size");
light_u_fov = shader_get_uniform(sh_light, "u_fov");
light_u_direction = shader_get_uniform(sh_light, "u_direction");
light_u_strength = shader_get_uniform(sh_light, "u_strength");
shadow_opacity = undefined;

// surface to draw the lighting to, low resolution for performance and crunshy look.
lighting_surface = surface_create(960, 540);

// creating a vertex buffer for shadows.
vertex_format_begin();

// NOTE: 
// position is only needed as shadows are always black. 
// 3D for z pos when layering lights and shadows
vertex_format_add_position_3d();

vf = vertex_format_end();
vb = vertex_create_buffer();

music_sync_factor = 0;
music_sync_target_factor = 0.75;
music_sync_frame_change = 13;
music_sync_current_frame = 0;

function music_sync_loop(){
    music_sync_factor = lerp(music_sync_factor, music_sync_target_factor, 0.25);
    music_sync_current_frame++;
    if(music_sync_current_frame == music_sync_frame_change){
        music_sync_target_factor = music_sync_target_factor == 0? 0.75 : 0;
        music_sync_current_frame = 0;
    }
}

function set_room_clear_shadow_opacity(){
    if(roommanager_get_room_cleared(room) == true){
        shadow_opacity = 0.33;
    }
    else{
        shadow_opacity = 0.15;
    }
}

function bg_begin(){
    gpu_set_colorwriteenable(1,1,1,0);
}

function bg_end(){
    gpu_set_colorwriteenable(1,1,1,1);
}

var _bg_layer = layer_get_id("Background");
layer_script_begin(_bg_layer, bg_begin);
layer_script_end(_bg_layer, bg_end);

// disable application drawing.

// surface variable.
crt_surface =  surface_create(1920, 1080);

// handle
surface_width = shader_get_uniform(sh_crt, "surface_width");
surface_height = shader_get_uniform(sh_crt, "surface_height");

function draw_crt_lines(){
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
    shader_reset();
}

set_room_clear_shadow_opacity();

