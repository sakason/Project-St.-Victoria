extends SpringArm3D


func handle_camera():
	if Input.is_action_just_pressed("rotate_left"):
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(
			self,
			"rotation:y",
			self.rotation.y + PI/2,
			0.5
		)
	elif Input.is_action_just_pressed("rotate_right"):
		var tween = create_tween()	
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(
			self,
			"rotation:y",
			self.rotation.y - PI/2,
			0.5
		)
		
	elif Input.is_action_pressed("rotate_right") and Input.is_action_just_pressed("rotate_left"):
		print("reset rotation")
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(self,"rotation:y", PI, 0.5)

	
