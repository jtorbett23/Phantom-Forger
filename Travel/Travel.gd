extends Node2D

@onready var player : CharacterBody2D = $Player
var music_path : String = "res://assets/audio/music/nighttime.mp3"
@onready var office : TileMap = $Office
@onready var halls12 : TileMap = $"Halls1-2"
@onready var halls4 : TileMap = $Halls4


func _ready() -> void:
	AudioManager.play_music(music_path)
	Camera.set_follow(player)
	set_office_limits()

func post_fade_out() -> void:
	player.enable_player()

func set_office_limits() -> void:
	var cellsize = office.tile_set.tile_size
	# Camera Limits - Office
	var office_limits = office.get_used_rect()
	Camera.set_limits(office_limits.position.x * cellsize.x, office_limits.end.x * cellsize.x * office.scale.x)

func set_halls_limits() -> void:
	var cellsize = halls12.tile_set.tile_size
	# Camera Limits - Halls
	var halls_end_limits = halls4.get_used_rect()
	var halls_start_x = halls12.position.x
	var halls_end_x =  halls4.position.x + halls_end_limits.end.x * cellsize.x * halls4.scale.x
	Camera.set_limits(halls_start_x, halls_end_x)
