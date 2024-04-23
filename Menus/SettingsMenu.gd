extends Menu

class_name SettingsMenu

func _ready() -> void:
	self.set_content("Settings", 
	[	{"name": "Master", "type": Menu.types.HSLIDER, 
		"value": AudioManager.current_master_level, "callback": Callable(AudioManager, "set_master_volume")},
		{"name": "Music", "type": Menu.types.HSLIDER, 
		"value": AudioManager.current_music_level, "callback": Callable(AudioManager, "set_music_volume")},
		{"name": "Sound", "type": Menu.types.HSLIDER, 
		"value": AudioManager.current_sound_level, "callback": Callable(AudioManager, "set_sound_volume")},
		{"name":"Return to Main Menu", "callback": Callable(self, "return_to_main") }])

func return_to_main() -> void:
	self.queue_free()
