extends Area2D

export var speed: = 50.0
	
func _physics_process(delta: float) -> void:
	position.x += speed * delta
