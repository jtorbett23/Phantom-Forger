extends Node

func _ready():	
	UiManager.ui_theme = load("assets/Themes/ui.tres")
	var main_menu = MainMenu.new()
	UiManager.add(main_menu)
