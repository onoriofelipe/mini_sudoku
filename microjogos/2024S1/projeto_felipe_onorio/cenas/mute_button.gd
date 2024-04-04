extends Sprite2D

var muted: bool = false
@onready var audio_player: Node = $"../audio_stream_player"
var sprite_muted = preload("res://microjogos/2024S1/projeto_felipe_onorio/recursos/unmute_button.png")
var sprite_unmuted = preload("res://microjogos/2024S1/projeto_felipe_onorio/recursos/mute_button.png")

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
		set_texture(sprite_muted)
	else:
		audio_player.play()
		set_texture(sprite_unmuted)
		
