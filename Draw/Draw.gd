extends Node2D

var music_path : String = "res://assets/audio/music/drawing.mp3"
var travel_scene : String = "res://Travel/travel.tscn"
var ui : Array = []
var header : HeaderTurbo
var paintings : Array[PaintingState]
var test_paintings : Array
var draw_states : Array[DrawState]

@onready var reference : Sprite2D = $Reference
@onready var canvas_viewport : SubViewportContainer = $SubViewportContainer
@onready var drawer : Sprite2D = $"SubViewportContainer/SubViewport/Drawer"


func _ready() -> void:
	AudioManager.play_music(music_path)
	Camera.set_static()
	header = HeaderTurbo.new()
	Camera.add_ui(header)

	#Testing Line
	GameState.setup_paintings()

	# paintings = get_avaliable_paintings()
	test_paintings = GameState.paintings.values()
	var art_paths : Array[String] = []
	for p in test_paintings:
		draw_states.append(GameState.get_draw_state(p.id))
		art_paths.append(p.art_path)

	if test_paintings:
		reference.texture = load(test_paintings[0].art_path)
	
	header.set_content("DrawHeader",
	[ 	{"name": "Painting", "type": VOptionButtonTurbo, "values": art_paths, "callback": Callable(self, "change_painting")},
		{"name": "Brush Size", "type": VOptionButtonTurbo, "values": GameState.brush_size_to_int.keys(), "value" : "10px",
		 "callback": Callable(self, "set_brush_size")},
		{"name": "Brush Mode", "type" : VOptionButtonTurbo, "values": GameState.brush_mode_to_colour.keys(),
		 "callback": Callable(self, "set_brush_mode")},
		{"name":"Settings", "callback": Callable(self, "settings")},
		{"name":"Exit", "callback": Callable(self, "exit")}]
	)
	ui.append(header)

	# set art positions
	var remaining_screen_y : float = get_viewport().get_size().y - header.custom_minimum_size.y - reference.texture.get_size().y
	var remaining_screen_x : float = get_viewport().get_size().x - (2 * reference.texture.get_size().x)
	reference.position.y = header.custom_minimum_size.y + (remaining_screen_y / 2)
	reference.position.x = remaining_screen_x / 3
	canvas_viewport.position.y = header.custom_minimum_size.y + (remaining_screen_y / 2)
	canvas_viewport.position.x = reference.position.x + reference.texture.get_size().x +remaining_screen_x / 3

func get_avaliable_paintings() -> Array[PaintingState]:
	var available_paintings : Array[PaintingState] = []
	for state : PaintingState in GameState.paintings.values():
		if !state.placed:
			available_paintings.append(state)
	return available_paintings

func change_painting(index : int, dropdown: OptionButton):
	print(index)
	reference.texture = load(test_paintings[index].art_path)
	pass

func set_brush_mode(index : int, dropdown: OptionButton) -> void:
	drawer.colour = GameState.brush_mode_to_colour[dropdown.get_item_text(index)]

func set_brush_size(index: int, dropdown: OptionButton):
	drawer.radius = GameState.brush_size_to_int[dropdown.get_item_text(index)]

func settings() -> void:
	drawer.disable()
	Camera.add_ui(SettingsMenu.new(Callable(drawer, "enable")))

func exit() -> void:
	var travel_instance = load(travel_scene).instantiate()
	SceneManager.change_scene(self, travel_instance, Callable(travel_instance, "post_fade_out"), true)
