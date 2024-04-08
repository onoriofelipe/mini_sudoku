extends Node2D

signal win()
signal lose()

signal right_pressed
signal down_pressed
signal up_pressed
signal left_pressed
signal space_pressed

var node_to_be_consumed_1: Node2D
var node_to_be_consumed_2: Node2D
var node_to_be_consumed_string_1: String = ""
var node_to_be_consumed_string_2: String = ""
var base_node_name: String = "status_checker/area_cell_"
@onready var status_checker: Node2D = $status_checker

func _ready():
	var rand1 = randi() % 8
	var rand2 = randi() % 8
	if rand1 == rand2:
		rand2 = (rand2 + 1) % 8
	
	var initial_state_offset = ( randi() % 3 )
	var cell_map = status_checker.cell_map
	
	for cell in cell_map:
		cell.state = ( cell.state + initial_state_offset ) % 3
		if cell.state == cell.State.EMPTY:
			cell.state = cell.State.THIRD
		cell.update()
	
	var win_animations = $interface_static_elements/win_animation
	win_animations.hide()

func game_won():
	var win_animations = $interface_static_elements/win_animation
	win_animations.show()
	win_animations.play("default")
	win.emit()
	
func _process(_delta):
	pass

func _on_cursor_area_win_condition():
	#game_won()
	pass
