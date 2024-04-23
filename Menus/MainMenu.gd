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
	SceneManager.change_scene(self, travel_scene)

func settings() -> void:
	self.add_child(SettingsMenu.new())
