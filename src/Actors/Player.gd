extends Actor

func _physics_process(delta: float) -> void:
	var direction: = get_direction()
	_velocity = speed * direction

func get_direction() -> Vector2:
	# input strength ranges from -1 (left/up) to 1 (right/down)
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
		)
