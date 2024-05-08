extends Interactable

var results_scene : String = "res://Menus/results.tscn"

func interact(target = null) -> void:
	var popup = PopupTurbo.new("Are you sure you want to exit and end the heist?", PopupTurbo.QUESTION, Callable(target, "enable_player"), Callable(self, "exit"))
	Camera.add_ui(popup)

func exit():
	SceneManager.change_scene(self.owner, results_scene, Callable(), false, Camera.canvas)
