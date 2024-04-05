extends TouchScreenButton

#signal touch_button_pressed()
signal test_button_pressed()

# Called when the node enters the scene tree for the first time.
func _ready():
	#pressed.connect(get_parent()._on_touch_screen_button_0_pressed)
	test_button_pressed.connect($"../status_checker/area_cell_8/next_display"._on_handle_animation_test)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func emit_touch_button_pressed_for_cursor():
	test_button_pressed.emit()
	pass
