extends AnimatedSprite2D

enum State {EMPTY, FIRST, SECOND, THIRD }

var current_state: State = State.EMPTY

static var animation_watery = preload("res://microjogos/2024S1/projeto_felipe_onorio/cenas/watery.tres")
static var animation_flame_fluffy = preload("res://microjogos/2024S1/projeto_felipe_onorio/cenas/flame_fluffy.tres")
static var animation_flame_pixely = preload("res://microjogos/2024S1/projeto_felipe_onorio/cenas/flame_pixely.tres")
static var animation_leaf = preload("res://microjogos/2024S1/projeto_felipe_onorio/cenas/leaf.tres")

# returns next in queue and generates a new one
func pop_next():
	var popped_state = current_state
	populate_current_state_with_random()
	return popped_state

func populate_current_state_with_random():
	var next_random_offset = ( randi() % 3 ) + 1
	current_state = State.EMPTY + next_random_offset
	match current_state:
		State.EMPTY:
			print("should never have been called")
		State.FIRST:
			set_sprite_frames(animation_flame_fluffy)
		State.SECOND:
			set_sprite_frames(animation_watery)
		State.THIRD:
			set_sprite_frames(animation_leaf)
	play("default")

func _ready():
	populate_current_state_with_random()
	set_modulate(Color(1,1,1,0.4))

func _on_handle_animation_test():
	# lerp position to X over Y seconds
	# interpolate alpha to 1 over Y seconds
	# scale from 3 to 5 over Y seconds
	pass

func _process(delta):
	pass
