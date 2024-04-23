extends Interactable

func interact() -> void:
	SceneManager.change_scene(self, "res://Draw/draw.tscn")
