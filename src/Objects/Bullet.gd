extends Area2D

export var speed: = 400.0
	
	
func _physics_process(delta: float) -> void:
	var velocity := Vector2.RIGHT * speed
	translate(velocity * delta)
	

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free() # destroys bullet outside the view 
