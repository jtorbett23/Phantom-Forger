extends MenuTurbo

class_name MainMenu

var travel_scene : String = "res://Travel/travel.tscn"

func _ready() -> void:
	Camera.set_static()
	AudioManager.play_music("res://assets/audio/music/menu.mp3")
	self.set_content("Phantom Forger", 
	[	{"name": "Start Game", "callback": Callable(self, "start_game")}, 
		{"name":"Settings", "callback": Callable(self, "settings")}])

func start_game() -> void:
	var travel_instance = load(travel_scene).instantiate()
	SceneManager.change_scene(self, travel_instance, Callable(travel_instance, "post_fade_out"), true)

func settings() -> void:
	self.add_child(SettingsMenu.new())
