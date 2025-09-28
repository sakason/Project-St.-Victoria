extends Node3D

var grid_width = 10
var grid_height = 10
var grid = []
@onready var tile_scene = preload("res://scenes/turnbased_battle_scenes/enviroment/GridTile.tscn")
@onready var character =  preload("res://scenes/turnbased_battle_scenes/ships/battle_ship_test_scene.tscn")
var positions : Array[Vector2i] = []
var characters  = []
var is_selected = false

func _ready():
	initialize_grid()
	
func initialize_grid():
	# Array in die richtige Größe bringen
	#print("this is gridnode")
	grid.resize(grid_width)
	for x in range(grid_width):
		grid[x] = []
		grid[x].resize(grid_height)
		for y in range(grid_height):

			var visual_tile = tile_scene.instantiate()
			visual_tile.position = Vector3(x * 2.0, 0, y * 2.0)

			add_child(visual_tile)
			visual_tile.grid_x = x
			visual_tile.grid_z = y

			visual_tile.tile_clicked.connect(detect_click)
			grid[x][y] = {
				"is_occupied": false,
				"character": null,
				"type": "grass",
				"visual_node": visual_tile
			}
func status_manager():
	#sagt an welchefelder begehbar sind und updated diese
	pass

func detect_click(x,y):
	print("x:", x, "y:", y)
	if positions[0].x == x and positions[0].y == y and is_selected == false:
		is_selected = true 
		print("selected")
	else:
		move_characters(x,y)
func move_characters(x,y):
	#print("moving")
	if is_selected and not grid[x][y]["is_occupied"] and (positions[0].x != x or positions[0].y != y):
		# 1. Free old tile
		grid[positions[0]["x"]][positions[0]["y"]]["is_occupied"] = false

		# 2. Update position in data
		positions[0]["x"] = x
		positions[0]["y"] = y

		# 3. Reserve new tile
		grid[x][y]["is_occupied"] = true
		grid[x][y]["character"] = characters[0] # or wherever your character node is
		# 4. Move character visually (Tween for animation)
		var target_pos = Vector3(x * 2.0, 0, y * 2.0)
		var tween = get_tree().create_tween()
		tween.tween_property(characters[0], "global_position", target_pos, 0.5)

		print("Moved to: ", positions[0]["x"], positions[0]["y"])
		is_selected = false
	
	#wenn figur ausgewählt, feld begehbar und feld != figurenfeld ist -> bewege figur zu diesem Feld 
