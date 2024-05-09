extends MenuTurbo

class_name MainMenu

var music_path : String = "res://assets/audio/music/menu.mp3"

func _ready() -> void:
	Camera.set_static()
	AudioManager.play_music(music_path)
	self.set_content("Phantom Forger", 
	[	{"name": "Start Game", "callback": Callable(self, "start_game")}, 
		{"name":"Settings", "callback": Callable(self, "settings")},
		{"name":"Credits", "callback": Callable(self, "credits")}
		], "By Moshu")	

func start_game() -> void:
	GameState.reset()
	var story_menu : StoryMenu = StoryMenu.new(Callable(self, "close"))
	Camera.add_ui(story_menu)

func close() -> void:
	self.queue_free()

func settings():
	Camera.add_ui(SettingsMenu.new())

func credits():
	Camera.add_ui(CreditsMenu.new())
