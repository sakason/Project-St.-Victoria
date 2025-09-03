extends SpringArm3D


@export var camera_distance = 1
@export var current_perspective = 0
@export var rotation_divisor = 32

const TPS_POSITION = Vector3(0, 0, 1) # 0
const FPS_POSITION = Vector3(0, 0, 0) # 1
const CAMERA_MAX_DISTANCE = 5
const CAMERA_MIN_DISTANCE = 1
const rotation_limit_high = 0
const rotation_limit_low = 0

var max_rotation = 0


func _process(delta):
	if Input.is_action_just_released("rotate_left"):
		rotate_left()
	elif Input.is_action_just_pressed("rotate_right"):
		rotate_right()
		
	if Input.is_action_just_released("zoom_out"):
		if camera_distance < CAMERA_MAX_DISTANCE:
			camera_distance = max(camera_distance + 0.2, CAMERA_MIN_DISTANCE)
			zoom()

	if Input.is_action_just_released("zoom_in"):
		if camera_distance > 0.2:
			camera_distance = min(camera_distance - 0.2, CAMERA_MAX_DISTANCE)
			zoom()
					
func rotate_right():
	if max_rotation >= rotation_limit_low:
		var y = rotation.y
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "rotation:y", y + PI / 4, 0.5)
		max_rotation -= 1

func rotate_left():
	if max_rotation <= rotation_limit_high:
		var y = rotation.y
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_EXPO)
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "rotation:y", y - PI / 4, 0.5)
		max_rotation += 1

func zoom():
	var tween = create_tween()
	var step = tween.tween_property(self, "spring_length", camera_distance, 0.25)
	step.set_trans(Tween.TRANS_SINE)
	step.set_ease(Tween.EASE_OUT)
