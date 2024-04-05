extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	set_fill_mode(3)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_mana_gained(amount: int):
	value += amount
	pass
