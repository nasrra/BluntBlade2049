/// @description Draw
// You can write your code in this editor
var line_amount = array_length(lines_to_draw);
if(line_amount > 0){
	for(var i = 0; i < line_amount; i++){
		draw_line_width(
			lines_to_draw[i][0],
			lines_to_draw[i][1],
			lines_to_draw[i][2],
			lines_to_draw[i][3],
			line_width
		);
	}
}