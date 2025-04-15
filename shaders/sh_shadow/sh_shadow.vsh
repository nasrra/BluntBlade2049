attribute vec3 in_Position;

// position of the light source.
uniform vec2 u_position;

void main(){
    vec2 position = in_Position.xy;
    // if the point is the end of a shadow.
    if(in_Position.z > 0.){
        // move the point to a really far position to simulate a shadow length.
        vec2 distance = position - u_position;
        position += distance/sqrt(distance.x*distance.x + distance.y*distance.y) * 5000.;
    }
    vec4 object_space_pos = vec4( position.x, position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
}
