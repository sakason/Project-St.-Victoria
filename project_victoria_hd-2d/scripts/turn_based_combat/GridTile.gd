extends Node3D

signal tile_clicked(x, y)

@onready var body: StaticBody3D = $StaticBody3D

var grid_x : int
var grid_z : int
#func _ready():
	# Signal des StaticBody3D mit Root-Funktion verbinden
#	body.input_event.connect(_on_body_input_event)
	
func _on_static_body_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		emit_signal("tile_clicked", grid_x, grid_z)



#func _on_body_input_event(camera, event, pos, normal, shape_idx):
 #   if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
  #      emit_signal("tile_clicked", grid_x, grid_y)
