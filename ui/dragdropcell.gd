class_name DragDropCell 
extends Button

signal dragged(from: Vector2i, to:Vector2i)

var grid_position: Vector2i

# Called when clicking and starting to drag
func _get_drag_data(_at_position: Vector2) -> Variant:
	# empty cells cannot be dragged
	if not icon:
		return null
	
	# make preview text of icon
	var preview: TextureRect = TextureRect.new()
	preview.texture = icon
	set_drag_preview(preview)
	
	return self

# Called when holding drag and hovering over this button
# returns true if can drop data, false if not
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	# only allow DragDropCells to be dropped
	if not data is DragDropCell or data == self:
		return false
	
	grab_focus()
	return true


# Called when releasing the mouse button, only if _can_drop_data returned true
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	# Swap icons between this cell and the cell dragged from
	var temp: Texture2D = icon
	icon = data.icon
	data.icon = temp
	
	# Emit signal to connect this to other systems
	dragged.emit(data.grid_position, self.grid_position)
