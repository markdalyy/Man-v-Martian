extends Actor

export var score: = 100

# the first function called on every node in the scene tree 
# starting with the deepest node
func _ready() -> void:
	set_physics_process(false) # deactivate enemies (until in view)
	$AnimatedSprite.play()
	_velocity.x = -speed.x # opposite direction to player
	
	
func _on_BulletDetector_area_entered(area: Area2D) -> void:
	area.queue_free() # destroy bullet, so it doesn't keep going after collision
	die()


func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	# change direction if hits wall
	if is_on_wall():
		_velocity.x *= -1.0
		$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	if position.y > 1080:
		die()


func die() -> void:
	# ensure player won't collide with killed enemy
	$CollisionShape2D.set_deferred("disabled", true)
	queue_free() # deletes enemy node
	PlayerData.score += score
	
