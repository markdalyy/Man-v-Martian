extends Actor

export (PackedScene) var bullet_scene


func _ready():
	$AnimatedSprite.play()
	
	
func _physics_process(_delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL) # floor normal enables jump function
	animate(direction)
	shoot()


func _on_EnemyDetector_body_entered(body: Node) -> void:
	die()


func get_direction() -> Vector2:
	# input strength ranges from -1 (left/up) to 1 (right/down)
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0
		)
		
		
func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x # horizontal movement
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y # jump
	if is_jump_interrupted:
		out.y = 0.0
	return out
	
	
func animate(direction: Vector2) -> void:
	if direction.length() == 0:
		$AnimatedSprite.animation = "idle" # default
	if direction.x != 0:
		$AnimatedSprite.animation = "run"
		$AnimatedSprite.flip_h = direction.x < 0
		$AnimatedSprite.flip_v = false
#		$AnimatedSprite.offset = Vector2(0, 0) # reset offset
	elif direction.y < 0:
		#$AnimatedSprite.animation = "jump"
		pass
	elif Input.is_action_pressed("look_up"):
		$AnimatedSprite.animation = "up"
#		if $AnimatedSprite.flip_h == false:
#			$AnimatedSprite.offset = Vector2(-4, -6)
#		else:
#			$AnimatedSprite.offset = Vector2(4, -6)
	elif Input.is_action_pressed("lie_down"):
		$AnimatedSprite.animation = "down"
#		$AnimatedSprite.offset = Vector2(0, 8)
#	else:
#		$AnimatedSprite.offset = Vector2(0, 0)
		
		
func shoot() -> void:
	if Input.is_action_just_pressed("shoot"):
		var bullet = bullet_scene.instance()
		get_parent().add_child(bullet) # unbinds bullet speed from player speed
		# by adding bullet as a child of the root node (instead of Player)
		bullet.position = $BulletSpawnPosition.global_position
		if $AnimatedSprite.flip_h:
			bullet.set_direction(bullet.get_direction() * -1)
			bullet.position.x = bullet.position.x - 138
		
		
func die() -> void:
	queue_free()

