extends Node2D

export (PackedScene) var cell_pack
export (NodePath) var graph_path
export var editing_cell_color = Color()

onready var graph_node = get_node(graph_path)

func _on_Cursor_place_cell(in_current_block_node):
	var potential_block = block_exists(in_current_block_node)
	if(potential_block != null):
		print("Block exists!")
		potential_block.queue_free()
		return
	var cur_cell = cell_pack.instance()
	cur_cell.global_position = in_current_block_node.rect_global_position
	cur_cell.size = graph_node.spacing
	cur_cell.color = editing_cell_color
	add_child(cur_cell)

func int_vector(in_vector):
	return Vector2(int(in_vector.x), int(in_vector.y))

func block_exists(in_current_block):
	for c in get_children():
		if(c.is_in_group("cells")):
			#if(int_vector(c.global_position) == int_vector(in_position)):
			#	return c
			if(c.get_grid_position() == in_current_block.get_grid_position()):
				print("Block position: ", c.get_grid_position())
				return c
	return null
			