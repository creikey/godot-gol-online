extends ColorRect

export (NodePath) var graph_path
export (NodePath) var cursor_path

onready var graph_node = get_node(graph_path)
onready var cursor_node = get_node(cursor_path)

func _ready():
	set_process(true)

func _process(delta):
	rect_global_position = graph_node.snap_position(cursor_node.global_position - Vector2((graph_node.spacing/2),(graph_node.spacing/2)))
	
func get_grid_position():
	if(rect_size.x <= 1):
		printerr("Invalid grid position call!")
		return Vector2()
	else:
		return Vector2(int(rect_global_position.x) / int(rect_size.x), int(rect_global_position.y) / int(rect_size.x))