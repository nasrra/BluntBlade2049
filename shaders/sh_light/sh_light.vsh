attribute vec3 in_Position;                  // (x,y,z)

// position of the pixel, passing to the frag shader.
varying vec2 position;
// the layer to draw the shadow on.
uniform float u_layer;

void main(){
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, u_layer, 1.0); //<-- -0.5 from the layer to draw on top of lights.
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;    
    
    // make position persist to the fragment shader.
    position = in_Position.xy;
}
