extends Node2D

@onready var player = $Player

func _ready() -> void:
	AudioManager.play_music("res://assets/audio/music/daytime.mp3")
	Camera.set_follow(player)
