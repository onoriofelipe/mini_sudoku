extends TouchScreenButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(get_parent()._on_touch_screen_button_0_pressed)
	pressed.connect($"../..".scan_for_completions)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#region deprecated
func emit_touch_button_pressed_for_cursor():
	#touch_button_pressed.emit(get_parent())
	pass
#endregion
