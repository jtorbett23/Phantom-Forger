extends Menu

class_name SettingsMenu

func _ready() -> void:
	self.set_content("Settings", ["Return to Main Menu"])

func handle_input(action) -> void:
	if action == "Return to Main Menu":
		return_to_main()


func return_to_main() -> void:
	self.queue_free()
