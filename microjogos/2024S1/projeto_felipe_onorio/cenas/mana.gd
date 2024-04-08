extends TextureProgressBar

func _ready():
	set_fill_mode(3)


func _process(delta):
	pass

func _on_mana_gained(amount: int):
	value += amount
	pass
