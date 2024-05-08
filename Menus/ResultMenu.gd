extends MenuTurbo

var music_path : String = "res://assets/audio/music/daytime.mp3"

func _ready() -> void:
	Camera.set_static()
	AudioManager.play_music(music_path)

	var menu_content : Array[Dictionary] = [
		{"name":"Exit", "callback" : Callable(self, "exit")}
	]

	# if GameState.suspicion < 100:
	# 	menu_content.append({"name":"Continue"})

	self.set_content("Results", 
	menu_content)

func exit():
	SceneManager.change_scene(self, MainMenu, Callable(), false, Camera.canvas)



