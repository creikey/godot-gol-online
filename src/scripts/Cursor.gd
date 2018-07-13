extends Node2D

signal place_cell(in_current_block_node)

export var move_speed = 100.0
export var zoom_speed = 0.2
export (NodePath) var current_block_path

onready var current_block_node = get_node(current_block_path)

enum KEYS { LEFT, RIGHT, UP, DOWN }
var key_states = {LEFT:false, RIGHT:false, UP:false, DOWN:false}

var move_vector = Vector2()

func _ready():
	set_process(true)
	set_process_input(true)

func _process(delta):
	#print(global_position)
	global_position += move_vector * delta * move_speed

func _input(event):
	if event is InputEventKey:
		var will_call_update = true
		if(event.is_action("ui_left")):
			key_states[LEFT] = event.pressed
		elif(event.is_action("ui_right")):
			key_states[RIGHT] = event.pressed
		elif(event.is_action("ui_up")):
			key_states[UP] = event.pressed
		elif(event.is_action("ui_down")):
			key_states[DOWN] = event.pressed
		elif(event.is_action("ui_zoom_in") and event.pressed):
			$Camera2D.capped_zoom += Vector2(zoom_speed, zoom_speed)
		elif(event.is_action("ui_zoom_out") and event.pressed):
			$Camera2D.capped_zoom -= Vector2(zoom_speed, zoom_speed)
		elif(event.is_action_pressed("ui_place_cell")):
			emit_signal("place_cell", current_block_node)
		else:
			will_call_update = false
		if(will_call_update):
			on_new_key_states()
	elif event is InputEventMouseButton:
		if(event.is_action("ui_zoom_in")):
			$Camera2D.capped_zoom += Vector2(zoom_speed, zoom_speed)
		elif(event.is_action("ui_zoom_out")):
			$Camera2D.capped_zoom -= Vector2(zoom_speed, zoom_speed)

func on_new_key_states():
	move_vector = Vector2()
	if(key_states[LEFT]):
		move_vector.x -= 1
	if(key_states[RIGHT]):
		move_vector.x += 1
	if(key_states[UP]):
		move_vector.y -= 1
	if(key_states[DOWN]):
		move_vector.y += 1