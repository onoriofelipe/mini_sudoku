extends Control


signal xxxx()
signal left_pressed()
signal right_pressed()
signal up_pressed()
signal down_pressed()
signal space_pressed()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _input(event):
	#if event.is_action_just_pressed("esquerda"):
	#if Input.is_action_just_pressed("esquerda"):
		#print("esquerda handled")
		#left_pressed.emit()
	if Input.is_action_just_pressed("acao"):
		print("acao haAAndled")
		space_pressed.emit()
	if Input.is_action_just_pressed("esquerda"):
		print("esquerda handled")
		left_pressed.emit()
	if Input.is_action_just_pressed("direita"):
		print("direita handled")
		right_pressed.emit()
	if Input.is_action_just_pressed("baixo"):
		print("baixo handled")
		down_pressed.emit()
	if Input.is_action_just_pressed("cima"):
		print("cima handled")
		up_pressed.emit()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

