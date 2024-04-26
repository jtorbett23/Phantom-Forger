extends Node

func _ready():
	# AssetsHelper.setup_paintings()
	# Add Main Menu
	var main_menu = MainMenu.new()
	Camera.add_ui(main_menu)