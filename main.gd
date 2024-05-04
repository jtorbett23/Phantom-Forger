extends Node

func _ready():
	var main_menu = MainMenu.new()
	Camera.add_ui(main_menu)
