tool
extends Node2D

export var test_size = 100 setget _set_test_size
export var color = Color() setget _set_color

var size = 0

func _set_test_size(itest_size):
	test_size = itest_size
	update()

func _set_color(icolor):
	color = icolor
	update()

func _draw():
	if(Engine.editor_hint):
		draw_rect(Rect2(Vector2(), Vector2(test_size, test_size)), color)
	else:
		draw_rect(Rect2(Vector2(), Vector2(size, size)), color)

func get_grid_position():
	if(size <= 1):
		printerr("Invalid grid position call!")
		return Vector2()
	else:
		return Vector2(int(global_position.x) / int(size), int(global_position.y) / int(size))