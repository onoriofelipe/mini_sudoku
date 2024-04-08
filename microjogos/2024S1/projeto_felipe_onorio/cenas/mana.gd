extends TextureProgressBar

func _ready():
	set_fill_mode(3)

var accumulated_deltas = 0

func _process(delta):
	accumulated_deltas += delta
	if(accumulated_deltas >= 0.1):
		accumulated_deltas -= 0.1
		value -= 1.5
		value = max(value, 0)
	pass

func _on_mana_gained(amount: int):
	value += amount
	pass
