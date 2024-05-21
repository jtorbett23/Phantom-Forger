extends MenuTurbo

class_name SettingsMenu

var close_callback : Callable

func _init(on_close_callback : Callable = Callable()):
	title_percentage_from_top = GameState.ui_title_from_top
	button_min_size = Vector2(140,30)
	self.close_callback = on_close_callback
	super._init("res://assets/Themes/ui-forger.png")

func _ready() -> void:
	theme = load("assets/Themes/ui.tres")
	AudioManager.test_sound_path = "res://assets/audio/sound/droplet.mp3"
	self.set_content("Settings", 
	[	{"name": "Herb Colour", "type": ColourDropDown, 
		"values" : GameState.name_to_colour.keys(), "value" : GameState.game_tint_name,
		"callback": Callable(self, "set_herb_tint")},
		{"name": "Master Volume", "type": HSliderTurbo, 
		"value": AudioManager.current_master_level, "callback": Callable(AudioManager, "set_master_volume")},
		{"name": "Music Volume", "type": HSliderTurbo, 
		"value": AudioManager.current_music_level, "callback": Callable(AudioManager, "set_music_volume")},
		{"name": "Sound Volume", "type": HSliderTurbo, 
		"value": AudioManager.current_sound_level, "callback": Callable(AudioManager, "set_sound_volume")},
		{"name":"Return", "callback": Callable(self, "close") }])

func close() -> void:
	self.queue_free()
	if !close_callback.is_null():
		close_callback.call()

func set_herb_tint(index : int, dropdown: OptionButton) -> void:
	var colour_name : String = dropdown.get_item_text(index)
	GameState.herb_colour = GameState.name_to_colour[colour_name]

