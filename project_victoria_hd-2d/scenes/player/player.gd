extends CharacterBody3D

# General
# Movement
const SPEED = 1.0
const JUMP_VELOCITY = 4.5

@export var frame = 0
@export var facing = 0
@onready var menu = $menu

var paused = true

# Health and damage
@onready var health_bar = $CanvasLayer/health_bar
var taking_damage = false
var dead = false

var health = 100
var last_damage_time = 0.0
var max_health = 100
var health_regen_delay = 3
var health_regen_rate = 5  

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	$HealthRegenTimer.start()
	last_damage_time = Time.get_ticks_msec()
	pause_menu()
	health_bar.init_health(health)

func _physics_process(delta: float) -> void:
	print(health)
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("pause"):
		pause_menu()
	#check_health_regen(delta)

func pause_menu():
	if paused == false: 
		menu.show()
		Engine.time_scale = 0
		paused = true
	else:
		menu.hide()
		Engine.time_scale = 1
		paused = false
		
func handle_walk_animation(direction):
	if direction == Vector2(0, 0):
		$AnimationPlayer.stop()
	else:
		$AnimationPlayer.play("walk")
	if direction.y == 1:
		facing = 0
	elif direction.y == -1:
		facing = 1
	elif direction.x == -1:
		$sprite3D.flip_h = false
		facing = 2
	elif direction.x == 1:
		$Sprite3D.flip_h = true
		facing = 2

func take_damage(amount: int):
	health -= amount
	taking_damage = true
	last_damage_time = Time.get_ticks_msec()
	health_bar.health = health
	
	if health <= 0:
		dead = true
		die()

func die():
	await get_tree().create_timer(1.5).timeout
	get_tree().reload_current_scene()

func check_health_regen(delta):
	if !dead and health < max_health:
		var time_since_damage = (Time.get_ticks_msec() - last_damage_time) / 1000.0  # Convert to seconds
		if time_since_damage >= health_regen_delay:
			health += health_regen_rate * delta
			health_bar.health = health  
			health = min(health, max_health)
			
func _on_health_regen_timer_timeout() -> void:
	check_health_regen($HealthRegenTimer.wait_time)
