attribute vec3 in_Position;

uniform vec2 u_cam_pos;    // Camera position
uniform vec2 u_position;   // Light source position

void main(){
    // Adjust the position relative to the camera
    vec2 position = in_Position.xy - u_cam_pos;

    // Vector from light source to the position
    vec2 distance = position - u_position;

    // Squared distance
    float len2 = dot(distance, distance) + 0.0001;

    // Use inversesqrt for fast 1/sqrt(len2)
    float offsetFactor = max(0.0, in_Position.z) * 2500.0;
    position += distance * offsetFactor * inversesqrt(len2);

    // Final position
    vec4 object_space_pos = vec4(position, 0.0, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
}
