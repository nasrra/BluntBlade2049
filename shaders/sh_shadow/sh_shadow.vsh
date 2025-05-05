precision mediump float;

attribute vec3 in_Position;
uniform vec2 u_cam_pos;    // Camera position
uniform vec2 u_position;   // Light source position
#define OFFSET_SCALE 1000.0  // Lower the constant

void main(){
    // Adjust the position relative to the camera
    vec2 position = in_Position.xy - u_cam_pos;

    // Vector from light source to the position
    vec2 distance = position - u_position;

    // Use squared distance
    float len2 = distance.x * distance.x + distance.y * distance.y;

    // Avoid normalizing by scaling the direction directly
    float offsetFactor = max(0.0, in_Position.z) * OFFSET_SCALE;
    position += distance * offsetFactor / sqrt(len2);  // Use direction scale directly

    // Final position
    vec4 object_space_pos = vec4(position, 0.0, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
}
