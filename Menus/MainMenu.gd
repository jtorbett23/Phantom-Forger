extends Menu

class_name MainMenu

func _ready() -> void:
	AudioManager.play_music("res://assets/audio/music/music/menu.mp3")
	self.set_content("Main Menu", 
	[	{"name": "Start Game"}, 
		{"name":"Settings"}])

func handle_input(input) -> void:
	if input.name == "Start Game":
		start_game()
	elif input.name == "Settings":
		settings()

func start_game() -> void:
	print("Start Game")

func settings() -> void:
	self.add_child(SettingsMenu.new())
