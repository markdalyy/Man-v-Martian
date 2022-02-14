extends Actor


# the first function called on every node in the scene tree 
# starting with the deepest node
func _ready() -> void:
	$AnimatedSprite.play()
	_velocity.x = -speed.x # opposite direction to player

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	# change direction if hits wall
	if is_on_wall():
		_velocity.x *= -1.0
		$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
