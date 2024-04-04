extends Sprite2D

var muted: bool = false
@onready var audio_player: Node = $"../audio_stream_player"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_touch_screen_button_0_pressed():
	muted = !muted
	if muted:
		audio_player.stop()
	else:
		audio_player.play()
