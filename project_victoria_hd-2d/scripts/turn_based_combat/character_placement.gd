extends Node3D

func _ready():
	# Finde die platzierten Charakter-Nodes
	var player = $player_1
	#var enemy = $Enemy
	Gridmanager.characters.append($player_1)
	_place_character_on_grid(player)

	#_place_character_on_grid(enemy)		
func _place_character_on_grid(character_node):
	# Die 3D-Position in eine Gitterposition umrechnen
	var x = round(character_node.global_position.x)
	var z = round(character_node.global_position.z)
	
	if x >= 0 and x < Gridmanager.grid_width and z >= 0 and z < Gridmanager.grid_height:
		Gridmanager.grid[x][z].is_occupied = true
		Gridmanager.grid[x][z].character = character_node
		print("Figur ", character_node.name, " wurde an Grid-Position (", x, ", ", z, ") platziert.")
		Gridmanager.positions.append(Vector2i(x,z))
#func move_character():
#	pass
		#1. location mouseclick = location character
		#2. location and validation  of destination
		#3. update of characters position
		
