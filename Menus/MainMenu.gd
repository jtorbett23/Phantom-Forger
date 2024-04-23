extends Menu

class_name MainMenu

func _ready() -> void:
	AudioManager.play_music("res://assets/audio/music/menu.mp3")
	self.set_content("Phantom Forger", 
	[	{"name": "Start Game", "callback": Callable(self, "start_game")}, 
		{"name":"Settings", "callback": Callable(self, "settings")}])

func start_game() -> void:
	print("Start Game")

func settings() -> void:
	self.add_child(SettingsMenu.new())
