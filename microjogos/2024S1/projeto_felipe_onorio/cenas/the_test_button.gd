extends TouchScreenButton

signal test_button_pressed()

func _ready():
	test_button_pressed.connect($"../status_checker/area_cell_8/next_display"._on_handle_animation_test)

func _process(delta):
	pass

func emit_touch_button_pressed_for_cursor():
	test_button_pressed.emit()
