extends Interactable

func interact(_target = null) -> void:
	SceneManager.change_scene(self.owner, "res://Draw/draw.tscn")
