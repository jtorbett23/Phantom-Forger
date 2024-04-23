extends Control

var music_path : String = "res://assets/audio/music/drawing.mp3"

func _ready() -> void:
	AudioManager.play_music(music_path)
	Camera.set_static()