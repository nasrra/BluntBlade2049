/// @description Insert description here
// You can write your code in this editor

function Quad(_vb, _x1, _y1, _x2, _y2){
    vertex_position_3d(_vb, _x1, _y1,0);
    vertex_position_3d(_vb, _x1, _y1,1);
    vertex_position_3d(_vb, _x2, _y2,0);

    vertex_position_3d(_vb, _x1, _y1,1);
    vertex_position_3d(_vb, _x2, _y2,0);
    vertex_position_3d(_vb, _x2, _y2,1);
}

if(mouse_check_button_pressed(mb_left)){
        instance_create_depth(mouse_x, mouse_y, depth, obj_light);
}

if(mouse_check_button_pressed(mb_right)){
    for(var i = 0; i < 100; i++){
        instance_create_depth(mouse_x, mouse_y, depth, obj_light);
    }
}

vertex_begin(vb, vf);
var _vb = vb;
var _scale_factor = scale_factor;
with(obj_wall){
    // defining two quads, the diagonals, of an object to draw a shadow from.
    Quad(_vb, x*_scale_factor,y*_scale_factor,(x+sprite_width)*_scale_factor, (y+sprite_height)*_scale_factor);
    Quad(_vb, (x+sprite_width)*_scale_factor,y*_scale_factor,x*_scale_factor, (y+sprite_height)*_scale_factor);
}
vertex_end(vb)