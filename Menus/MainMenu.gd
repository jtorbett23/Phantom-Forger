extends MenuTurbo

class_name MainMenu

var travel_scene : String = "res://Travel/travel.tscn"
var music_path : String = "res://assets/audio/music/menu.mp3"

func _ready() -> void:
	Camera.set_static()
	AudioManager.play_music(music_path)
	self.set_content("Phantom Forger", 
	[	{"name": "Start Game", "callback": Callable(self, "start_game")}, 
		{"name":"Settings", "callback": Callable(self, "settings")}])

func start_game() -> void:
	GameState.setup_paintings(8)
	var travel_instance = load(travel_scene).instantiate()
	SceneManager.change_scene(self, travel_instance, Callable(travel_instance, "post_fade_out"), true)

func settings() -> void:
	self.add_child(SettingsMenu.new())
