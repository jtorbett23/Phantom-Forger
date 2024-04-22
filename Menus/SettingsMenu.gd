extends Menu

class_name SettingsMenu

func _ready() -> void:
	self.set_content("Settings", 
	[	{"name": "Music", "type": "HSlider", "value": AudioManager.current_music_level},
		{"name": "Sound", "type": "HSlider", "value": AudioManager.current_sound_level},
		{"name":"Return to Main Menu"}])

func handle_input(input) -> void:
	if input.name == "Return to Main Menu":
		return_to_main()
	elif input.name == "Music":
		AudioManager.set_music_volume(input.value)
	elif input.name == "Sound":
		AudioManager.set_sound_volume(input.value)

func return_to_main() -> void:
	self.queue_free()
