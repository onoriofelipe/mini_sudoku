extends Sprite2D

# TODO: sprite with indication of how many unique in this row/col

signal mark_cells()

@export var index: int = -1
@export var cells: Array[Node2D] = []

func _ready():
	for cell in cells:
		mark_cells.connect(cell.mark_for_destruction)
	pass

func _process(delta):
	pass
	
# TODO: add more side-effects
func on_row_complete():
	mark_member_cells()
	pass

func mark_member_cells():
	mark_cells.emit()
