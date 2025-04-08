/// @description Insert description here
// You can write your code in this editor
desired_x = target.x;
desired_y = target.y;

x += (desired_x - x)/follow_speed;
y += (desired_y - y)/follow_speed;

// factor by 0.5 to remain centred.
camera_set_view_pos(view_camera[0],x-(cam_width*0.5),y-(cam_height*0.5));