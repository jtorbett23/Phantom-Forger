extends MenuTurbo

class_name MainMenu

var music_path : String = "res://assets/audio/music/menu.mp3"

func _init():
	title_percentage_from_top = GameState.ui_title_from_top
	button_min_size = Vector2(140,30)
	super._init("res://assets/Themes/ui-forger.png")


func _ready() -> void:
	# Camera.set_static()
	AudioManager.play_music(music_path)
	self.set_content("Phantom Forger", 
	[	{"name": "Start Game", "callback": Callable(self, "start_game")}, 
		{"name":"Settings", "callback": Callable(self, "settings")},
		{"name":"Credits", "callback": Callable(self, "credits")}
		])
	
	theme = load("assets/Themes/ui.tres")

func start_game() -> void:
	GameState.reset()
	var story_menu : StoryMenu = StoryMenu.new(Callable(self, "close"))
	UiManager.add(story_menu)
	queue_free()

func close() -> void:
	self.queue_free()

func settings():
	UiManager.add(SettingsMenu.new())

func credits():
	UiManager.add(CreditsMenu.new())
