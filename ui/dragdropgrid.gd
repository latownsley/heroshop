class_name DragDropGrid
extends GridContainer

signal dragged(from: Vector2i, to: Vector2i)

# 2D array of cells [row][column]
var _cells: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# initialize _cells array
	for x in columns:
		_cells.append([])
	
	var row: int = 0
	var column: int = 0
	
	for cell in get_children():
		_cells[column].append(cell)
		# tell each cell its grid position
		cell.grid_position = Vector2i(column, row)
		# connect dragged signal
		cell.dragged.connect(dragged.emit)
		column += 1
		if column >= columns:
			column = 0
			row += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
