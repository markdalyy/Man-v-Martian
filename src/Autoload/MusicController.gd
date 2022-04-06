extends Node

var music = load("res://assets/POL-elevators-long.wav")


func start_playing():
	$Music.stream = music
	$Music.play()
