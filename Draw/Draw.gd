extends Node2D

var music_path : String = "res://assets/audio/music/drawing.mp3"
var travel_scene : String = "res://Travel/travel.tscn"
var ui : Array = []
var header : HeaderTurbo

@onready var reference : Sprite2D = $Reference
@onready var canvas : Sprite2D = $Canvas

func _ready() -> void:
	AudioManager.play_music(music_path)
	Camera.set_static()
	header = HeaderTurbo.new()
	Camera.add_ui(header)
	header.set_content("DrawHeader",
	[ 
		{"name":"Exit", "callback": Callable(self, "exit")}]
	)
	ui.append(header)

	# set art positions
	var remaining_screen_y : float = get_viewport().get_size().y - header.custom_minimum_size.y - reference.texture.get_size().y
	var remaining_screen_x : float = get_viewport().get_size().x - (2 * reference.texture.get_size().x)
	reference.position.y = header.custom_minimum_size.y + (remaining_screen_y / 2)
	reference.position.x = remaining_screen_x / 3
	canvas.position.y = header.custom_minimum_size.y + (remaining_screen_y / 2)
	canvas.position.x = reference.position.x + reference.texture.get_size().x +remaining_screen_x / 3

func exit() -> void:
	var travel_instance = load(travel_scene).instantiate()
	SceneManager.change_scene(self, travel_instance, Callable(travel_instance, "post_fade_out"), true)
