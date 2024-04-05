extends Label

var current_score: int = 0
enum State {EMPTY, FIRST, SECOND, THIRD }

signal fire_mana_gained(amount: int)
signal water_mana_gained(amount: int)
signal plant_mana_gained(amount: int)
#signal mana_gained(state: State)

#func add_text(text_to_add):
	#text = text_to_add

# Called when the node enters the scene tree for the first time.
func _ready():
	fire_mana_gained.connect($"../fire_mana"._on_mana_gained)
	water_mana_gained.connect($"../water_mana"._on_mana_gained)
	plant_mana_gained.connect($"../plant_mana"._on_mana_gained)
	#push_font_size(50)
	#push_outline_size(10)
	#push_outline_color(Color(0,0,0,1))
	#set_cell_padding(Rect2(Vector2(200,200), Vector2(50,5)))
	#add_text("0")
	#text = "zzzzz"
	#set_text("YYYYYY")
	pass # Replace with function body.

func clear_text():
	print("text should have been cleared")
	text = ""

func accumulate_state(state: State):
	current_score += 1
	match state:
		State.FIRST:
			fire_mana_gained.emit(calculate_mana_gain())
		State.SECOND:
			water_mana_gained.emit(calculate_mana_gain())
		State.THIRD:
			plant_mana_gained.emit(calculate_mana_gain())
	update_label()
	pass
	
func update_label():
	clear_text()
	do_some_formatting()
	#add_text(str(current_score))
	text = str(current_score)

func calculate_mana_gain():
	return 20

func do_some_formatting():
	#push_font_size(50)
	#push_outline_size(10)
	#push_outline_color(Color(0,0,0,1))
	#set_cell_padding(Rect2(Vector2(200,200), Vector2(50,5)))
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
