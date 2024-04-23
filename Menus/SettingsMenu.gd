extends MenuTurbo

class_name SettingsMenu

func _ready() -> void:
	AudioManager.test_sound_path = "res://assets/audio/sound/droplet.mp3"
	self.set_content("Settings", 
	[	{"name": "Master", "type": MenuTurbo.types.HSLIDER, 
		"value": AudioManager.current_master_level, "callback": Callable(AudioManager, "set_master_volume")},
		{"name": "Music", "type": MenuTurbo.types.HSLIDER, 
		"value": AudioManager.current_music_level, "callback": Callable(AudioManager, "set_music_volume")},
		{"name": "Sound", "type": MenuTurbo.types.HSLIDER, 
		"value": AudioManager.current_sound_level, "callback": Callable(AudioManager, "set_sound_volume")},
		{"name":"Return", "callback": Callable(self, "close") }])

func close() -> void:
	self.queue_free()
