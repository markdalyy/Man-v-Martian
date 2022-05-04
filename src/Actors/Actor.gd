extends KinematicBody2D
class_name Actor # to be extended by other actors

# Vector2 takes values for x and y axis 
const FLOOR_NORMAL: = Vector2.UP  # Vector2(0.0, -1.0)

# export makes variable configurable in the Inspector tab
export var speed: = Vector2(250.0, 875.0) # max speed on each axis
export var gravity: = 2000.0

# amount of pixels player moves per second in a given direction
var _velocity: = Vector2.ZERO # Vector2(0.0, 0.0)
# by default, the player will not move


# Notes:

# godot will call _physics_process every frame (30-60 fps)
# generally where you want to place the player movement
# for objects that will collide, i.e. detect floor and walls

# delta is time elapsed since previous frame (not constant)
# makes code frame rate independent
# e.g. to get the amount of pixels you want to move in one frame: velocity * delta
# if game slows down the player stil moves at the same speed
# slow computer or resource heavy scene
