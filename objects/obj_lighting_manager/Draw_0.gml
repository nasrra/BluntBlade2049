/// @description Insert description here
// You can write your code in this editor
var _light_u_position = light_u_position;
var _shadow_u_position = shadow_u_position;
var _vb = vb;
with(obj_light){
    shader_set(sh_light);
    // setting the shader light position to this light instance.
    shader_set_uniform_f(_light_u_position, x, y);
    draw_rectangle(0,0, room_width, room_height, 0);

    // submit the quad vertex buffer for drawing. 
    shader_set(sh_shadow);
    shader_set_uniform_f(_shadow_u_position, x, y);
    vertex_submit(_vb, pr_trianglelist,-1); // <-- computers draw triangles lol :)
}
shader_reset();