extends Node

func _ready():
	# AssetsHelper.setup_paintings()

	# Add Main Menu
	var main_menu = MainMenu.new()
	add_child(main_menu)