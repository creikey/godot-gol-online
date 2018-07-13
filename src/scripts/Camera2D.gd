extends Camera2D

export var lower_limit = 0.2
export var higher_limit = 5.0

var capped_zoom = Vector2() setget _set_capped_zoom

func _set_capped_zoom(new_zoom):
	new_zoom.x = clamp(new_zoom.x, lower_limit, higher_limit)
	new_zoom.y = clamp(new_zoom.y, lower_limit, higher_limit)
	capped_zoom = new_zoom
	zoom = new_zoom