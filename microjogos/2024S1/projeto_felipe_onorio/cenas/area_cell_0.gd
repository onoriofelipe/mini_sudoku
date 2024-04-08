extends Area2D

@export var right_neighbor: Node = null
@export var left_neighbor: Node = null
@export var up_neighbor: Node = null
@export var down_neighbor: Node = null
@export var row: int = -1
@export var column: int = -1

var marked_for_destruction: bool = false

signal cell_popped(state: State)

enum State {EMPTY, FIRST, SECOND, THIRD }
var exterminated : bool = false

@export var state : State = State.THIRD
var last_state : State = State.EMPTY
@onready var sprite_animation: Node2D = get_child(0)
@onready var next_display: Node2D = $next_display
@onready var cursor_area: Node = $"../../cursor_area"
@onready var score_label: Node = $"../../interface_static_elements/simple_score_label"
static var animation_watery = preload("res://microjogos/2024S1/projeto_felipe_onorio/cenas/watery.tres")
static var animation_flame_fluffy = preload("res://microjogos/2024S1/projeto_felipe_onorio/cenas/flame_fluffy.tres")
static var animation_flame_pixely = preload("res://microjogos/2024S1/projeto_felipe_onorio/cenas/flame_pixely.tres")
static var animation_leaf = preload("res://microjogos/2024S1/projeto_felipe_onorio/cenas/leaf.tres")

func change_next_state():
	state = (state + 1) % 4
	if state == State.EMPTY:
		state += 1
	match state:
		State.EMPTY:
			print("should never have been called")
		State.FIRST:
			sprite_animation.set_sprite_frames(animation_flame_fluffy)
		State.SECOND:
			sprite_animation.set_sprite_frames(animation_watery)
		State.THIRD:
			sprite_animation.set_sprite_frames(animation_leaf)
	sprite_animation.play("default")

func update():
	state = state - 1
	change_next_state()

func _ready():
	#cursor_area.row_and_column_complete.connect(self.maybe_destroy_self)
	cell_popped.connect(score_label.accumulate_state)
	pass

# TODO: change for handling from row node notification
#func maybe_destroy_self(other_row: int, other_column: int):
	#if (row == other_row) || ( column == other_column ) :
		#destroy_self_get_next_add_points()
		#pass

# TODO: add more side-effects if needed
func destroy_self_if_marked():
	if (marked_for_destruction):
		destroy_self_get_next_add_points()
		marked_for_destruction = false
		#print("marked for destruction: ", name)
	else:
		#print("not marked for destruction: ", name)
		pass

func destroy_self_get_next_add_points():
	#destroy_self()
	get_next()
	add_points()

# TODO: consider adding extra metainformation here, for example in the case where
#       a cell is marked more than once, could have extra reward weights by using
#       some struct or even just int instead of bool
func mark_for_destruction():
	marked_for_destruction = true

func get_next():
	last_state = state
	# play_destruction_animation_shader_or_vfx()
	state = next_display.pop_next()
	update()
	pass

func add_points():
	cell_popped.emit(last_state)
	pass

func _process(_delta):
	pass

func _on_cursor_area_activate_cell():
	change_next_state()

func _on_touch_screen_button_0_pressed():
	_on_cursor_area_activate_cell()

