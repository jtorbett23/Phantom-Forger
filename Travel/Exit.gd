extends Interactable

func interact(target = null) -> void:
	#TODO: Change to end scene
	var popup = PopupTurbo.new("Are you sure you want to exit and end the heist?", PopupTurbo.QUESTION, Callable(self, "exit"),  Callable(target, "enable_player"))
	Camera.add_ui(popup)

func exit():
	SceneManager.change_scene(self.owner, MainMenu)
