extends Interactable

func interact(_target = null) -> void:
	#TODO: Change to end screne
	SceneManager.change_scene(self.owner, MainMenu)
