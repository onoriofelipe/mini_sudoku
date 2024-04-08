extends Label

var current_score: int = 0
enum State {EMPTY, FIRST, SECOND, THIRD }

signal fire_mana_gained(amount: int)
signal water_mana_gained(amount: int)
signal plant_mana_gained(amount: int)

func _ready():
	fire_mana_gained.connect($"../fire_mana"._on_mana_gained)
	water_mana_gained.connect($"../water_mana"._on_mana_gained)
	plant_mana_gained.connect($"../plant_mana"._on_mana_gained)

func clear_text():
	#print("text should have been cleared")
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
	text = str(current_score)

func calculate_mana_gain():
	return 20

func do_some_formatting():
	pass

func _process(delta):
	pass
