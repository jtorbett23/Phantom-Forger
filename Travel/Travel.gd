extends Node2D

@onready var player : CharacterBody2D = $Player
var music_path : String = "res://assets/audio/music/nighttime.mp3"

func _ready() -> void:
	AudioManager.play_music(music_path)
	Camera.set_follow(player)

func post_fade_out() -> void:
	player.enable_player()
