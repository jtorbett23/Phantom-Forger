extends Interactable

func check_for_access() -> bool:
	for p : PaintingState in GameState.paintings.values():
		if not p.placed:
			return true
	return false

func interact(target = null) -> void:
	if check_for_access():
		SceneManager.change_scene(self.owner, "res://Draw/draw.tscn")
	else:
		var message : String = "You need a painting to be able to forge."
		var popup : PopupTurbo = PopupTurbo.new(message, PopupTurbo.MESSAGE, Callable(target, "enable_player"), Callable(), "res://assets/Themes/ui-forger-2.png")
		UiManager.add(popup)

