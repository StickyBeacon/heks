extends Node

@onready var camera : Camera2D = $"../Camera2D"

# Zoom settings
@export var zoom_speed: float = 0.1
@export var min_zoom: float = 0.1
@export var max_zoom: float = 2.0

@export var max_y_pos: float = 4500
@export var max_x_pos: float = 3000


# Panning
var dragging: bool = false
var last_mouse_pos: Vector2


func _unhandled_input(event: InputEvent) -> void:
	# --- Zoom with mouse wheel ---
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			zoom_camera(zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			zoom_camera(-zoom_speed)

		# Start/stop middle mouse drag
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				dragging = true
				last_mouse_pos = get_viewport().get_mouse_position()
			else:
				dragging = false

	# --- Pan with middle mouse drag ---
	elif event is InputEventMouseMotion and dragging:
		var mouse_pos = get_viewport().get_mouse_position()
		var delta = mouse_pos - last_mouse_pos
		camera.position -= delta / camera.zoom  # scale movement by current zoom
		
		camera.position.x = clamp(camera.position.x, -max_x_pos, max_x_pos)
		camera.position.y = clamp(camera.position.y, -max_y_pos, max_y_pos)
		
		
		last_mouse_pos = mouse_pos


#func zoom_camera(amount: float) -> void:
	#var new_zoom = camera.zoom.x + amount
	#new_zoom = clamp(new_zoom, min_zoom, max_zoom)
	#camera.zoom = Vector2(new_zoom, new_zoom)

func zoom_camera(amount: float) -> void:
	var old_zoom = camera.zoom.x
	var new_zoom = clamp(old_zoom + amount, min_zoom, max_zoom)
	
	if new_zoom == old_zoom:
		return  # No change
	
	# Get mouse position in world space before zoom
	var mouse_world_before = camera.get_global_mouse_position()
	
	# Apply zoom
	camera.zoom = Vector2(new_zoom, new_zoom)
	
	# Get mouse position in world space after zoom
	var mouse_world_after = camera.get_global_mouse_position()
	
	# Offset player/camera so the zoom feels centered on the cursor
	camera.position += mouse_world_before - mouse_world_after
	
	# Clamp to boundaries
	camera.position.x = clamp(camera.position.x, -max_x_pos, max_x_pos)
	camera.position.y = clamp(camera.position.y, -max_y_pos, max_y_pos)
