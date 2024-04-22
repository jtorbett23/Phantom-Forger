extends Menu

class_name MainMenu

func _ready() -> void:
	self.set_content("Main Menu", ["Start Game", "Settings"])

func handle_input(action) -> void:
	if action == "Start Game":
		start_game()
	elif action == "Settings":
		settings()

func start_game() -> void:
	print("Start Game")

func settings() -> void:
	self.add_child(SettingsMenu.new())
