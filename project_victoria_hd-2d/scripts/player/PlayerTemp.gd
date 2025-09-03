extends CharacterBody3D

@export var animation_frame = 0
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var facing = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


'func handle_walk_animation(direction):
	
	if direction == Vector2(0,0):
		$AnimationPlayer.stop()
		animation_frame = 0
	else:
		$AnimationPlayer.play("walk")
	if direction.y == 1: # Move Down facing = 0
		facing = 0
	elif direction.y == -1: # Move Up facing = 1
		facing = 1
	elif direction.x == -1: # Move Lft $Sprite3D.flip_h = false facing = 2
		$sprite3D.flip_h = false 
		facing = 2 
	elif direction.x == 1: # Move Right
		$Sprite3D.flip_h = true 
		facing = 2
	
	const FRAMES = 8
	$sprite3D.frame = animation_frame + (facing * FRAMES)`'
