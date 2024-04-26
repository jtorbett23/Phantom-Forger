extends MenuTurbo

class_name SettingsMenu

func _ready() -> void:
	AudioManager.test_sound_path = "res://assets/audio/sound/droplet.mp3"
	self.set_content("Settings", 
	[	{"name": "Game Colour", "type": MenuTurbo.types.COLOUR_DROPDOWN, 
		"value" : ["Default", "Blue", "Pink"], "callback": Callable(self, "set_game_tint")},
		{"name": "Master Volume", "type": MenuTurbo.types.HSLIDER, 
		"value": AudioManager.current_master_level, "callback": Callable(AudioManager, "set_master_volume")},
		{"name": "Music Volume", "type": MenuTurbo.types.HSLIDER, 
		"value": AudioManager.current_music_level, "callback": Callable(AudioManager, "set_music_volume")},
		{"name": "Sound Volume", "type": MenuTurbo.types.HSLIDER, 
		"value": AudioManager.current_sound_level, "callback": Callable(AudioManager, "set_sound_volume")},
		{"name":"Return", "callback": Callable(self, "close") }])

func close() -> void:
	self.queue_free()

func set_game_tint(index : int, dropdown: OptionButton) -> void:
	var colour_name : String = dropdown.get_item_text(index)
	if colour_name == "Default":
		Camera.set_tint(Camera.tint.GAME, Color.WHITE)
	elif colour_name == "Pink":
		Camera.set_tint(Camera.tint.GAME, Color.LIGHT_PINK)
	elif colour_name == "Blue":
		Camera.set_tint(Camera.tint.GAME, Color.LIGHT_BLUE)
