tool
extends Control

export var spacing = 10 setget _set_spacing
export var width = 1.0 setget _set_width
export var color = Color() setget _set_color

func _set_spacing(ispacing):
	spacing = ispacing
	update()

func _set_width(iwidth):
	width = iwidth
	update()

func _set_color(icolor):
	color = icolor
	update()

func _draw():
	# Draw vertical lines
	var x_offset = spacing
	while(x_offset < rect_size.x):
		draw_line(Vector2(x_offset, 0), Vector2(x_offset, rect_size.y), color, width)
		x_offset += spacing
	# Draw horizontal lines
	var y_offset = spacing 
	while(y_offset < rect_size.y):
		draw_line(Vector2(0, y_offset), Vector2(rect_size.x, y_offset), color, width)
		y_offset += spacing

func snap_number(in_number, mod):
	if((in_number % mod) >= mod/2):
		return in_number + (mod - (in_number % mod))
	else:
		return (in_number / mod) * mod

func snap_position(in_position):
	var to_return = Vector2(snap_number(int(in_position.x), int(spacing)), snap_number(int(in_position.y), int(spacing)))
	to_return.x = clamp(to_return.x, 0, rect_size.x)
	to_return.y = clamp(to_return.y, 0, rect_size.y)
	return to_return