extends Area2D

export var speed: = 500.0

var direction: = 1.0 setget set_direction, get_direction
	
	
func _physics_process(delta: float) -> void:
	var velocity := Vector2(direction, 0.0) * speed
	translate(velocity * delta)
	
	
func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free() # destroys bullet outside the view 


func set_direction(value: float) -> void:
	direction = value
	
func get_direction() -> float:
	return direction
