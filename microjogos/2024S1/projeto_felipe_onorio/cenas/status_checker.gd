extends Node2D

signal warn_row_complete_0()
signal warn_row_complete_1()
signal warn_row_complete_2()
signal warn_col_complete_0()
signal warn_col_complete_1()
signal warn_col_complete_2()

enum State {EMPTY, FIRST, SECOND, THIRD }

@onready var cell_map: Array = [
	$area_cell_0,
	$area_cell_1,
	$area_cell_2,
	$area_cell_3,
	$area_cell_4,
	$area_cell_5,
	$area_cell_6,
	$area_cell_7,
	$area_cell_8
]

@onready var row_0: Node = $row_0
@onready var row_1: Node = $row_1
@onready var row_2: Node = $row_2
@onready var col_0: Node = $col_0
@onready var col_1: Node = $col_1
@onready var col_2: Node = $col_2

@onready var rows: Array[Node] = [
	$row_0,
	$row_1,
	$row_2
]

@onready var cols: Array[Node] = [
	$col_0,
	$col_1,
	$col_2
]

@onready var row_map: Array = [
	[ cell_map[0],cell_map[1],cell_map[2] ],
	[ cell_map[3],cell_map[4],cell_map[5] ],
	[ cell_map[6],cell_map[7],cell_map[8] ]
]
@onready var column_map: Array = [
	[ cell_map[0],cell_map[3],cell_map[6] ],
	[ cell_map[1],cell_map[4],cell_map[7] ],
	[ cell_map[2],cell_map[5],cell_map[8] ]
]

func any_row_element_empty(row: int):
	var row_element_empty = ( row_map[row][0].state == State.EMPTY || 
								row_map[row][1].state == State.EMPTY || 
								row_map[row][2].state == State.EMPTY )
	return row_element_empty

func any_column_element_empty(column: int):
	var column_element_empty = ( column_map[column][0].state == State.EMPTY || 
								column_map[column][1].state == State.EMPTY || 
								column_map[column][2].state == State.EMPTY )
	return column_element_empty

# TODO: for row_ok and col_ok:
#       count unique, highlight row or column with color according to number of
#       unique items in this row or column
func row_ok(row: int):
	if any_row_element_empty(row):
		return false
		
	var all_unique = ( row_map[row][0].state != row_map[row][1].state &&
						row_map[row][1].state != row_map[row][2].state &&
						row_map[row][2].state != row_map[row][0].state )
	
	#warn_row_complete(row)
	return all_unique

func column_ok(column: int):
	if any_column_element_empty(column):
		return false
	var all_unique = ( column_map[column][0].state != column_map[column][1].state &&
						column_map[column][1].state != column_map[column][2].state &&
						column_map[column][2].state != column_map[column][0].state )
	#warn_col_complete(column)
	return all_unique

func warn_row_complete(index: int):
	match index:
		0:
			warn_row_complete_0.emit()
		1:
			warn_row_complete_1.emit()
		2:
			warn_row_complete_2.emit()
	pass
func warn_col_complete(index: int):
	match index:
		0:
			warn_col_complete_0.emit()
		1:
			warn_col_complete_1.emit()
		2:
			warn_col_complete_2.emit()
	pass

func check_row_and_column(row: int, column: int):
	return (row_ok(row) && column_ok(column))

func complete_rows_and_cols():
	var row_status = []
	row_status.append(row_ok(0))
	row_status.append(row_ok(1))
	row_status.append(row_ok(2))
	var col_status = []
	col_status.append(column_ok(0))
	col_status.append(column_ok(1))
	col_status.append(column_ok(2))
	var any_row_complete = (true in row_status)
	var any_col_complete = (true in col_status)
	var rows_ready: Array[int] = []
	var cols_ready: Array[int] = []
	var any_cross_completion = false
	if ( any_row_complete && any_col_complete ):
		any_cross_completion = true
		var index: int = 0
		for status in row_status:
			if(status == true):
				rows_ready.append(index)
			index += 1
		index = 0
		for status in col_status:
			if(status == true):
				cols_ready.append(index)
			index += 1
	# TODO: turn this return data into a struct
	return [any_cross_completion, rows_ready, cols_ready]
#func map_bool_to_

# TODO: consider using a queue to process one iteration cycle at a time so it's
#       easier to manage the logic in-between
func scan_for_completions():
	var completion_data = [true]
	var counter: int = 0
	while (completion_data[0] == true):
		counter += 1
		print("iteration: ", counter)
		#print("completion data: ", completion_data)
		completion_data = complete_rows_and_cols()
		# TODO: animations and etc likely here
		
		# this step only marks cells
		for row_index in completion_data[1]:
			#print("row index (rows that were completed and signaled): ", row_index)
			warn_row_complete(row_index)
		for col_index in completion_data[2]:
			#print("col index (cols that were completed and signaled): ", col_index)
			warn_col_complete(col_index)
		# this step destroys marked cells only once, with possibly extra metadata
		# added
		destroy_marked_cells()
	pass

func destroy_marked_cells():
	for cell in cell_map:
		cell.destroy_self_if_marked()

# interface: every change (board iteration, movement does not trigger this),
#            then check for completions, then do a pass and mark affected cells
#            as complete, then destroy these, then wait animations, then recheck

# TODO: functions for highlighting all repeated cells in a row or in a column

func _init():
	pass

func _ready():
	warn_row_complete_0.connect($row_0.on_row_complete)
	warn_row_complete_1.connect($row_1.on_row_complete)
	warn_row_complete_2.connect($row_2.on_row_complete)
	warn_col_complete_0.connect($col_0.on_row_complete)
	warn_col_complete_1.connect($col_1.on_row_complete)
	warn_col_complete_2.connect($col_2.on_row_complete)
	pass

func _process(_delta):
	pass
