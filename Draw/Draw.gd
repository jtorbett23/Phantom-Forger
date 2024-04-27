extends Control

var music_path : String = "res://assets/audio/music/drawing.mp3"
var travel_scene : String = "res://Travel/travel.tscn"

var ui : Array = []
var header : HeaderTurbo

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

	#TODO: Setup Drawing Scene

func exit() -> void:
	var travel_instance = load(travel_scene).instantiate()
	SceneManager.change_scene(self, travel_instance, Callable(travel_instance, "post_fade_out"), true)
