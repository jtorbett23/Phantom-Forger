extends Node2D

var music_path : String = "res://assets/audio/music/drawing.mp3"
var travel_scene : String = "res://Travel/travel.tscn"
var ui : Array = []
var header : HeaderTurbo
var paintings : Array[PaintingState]
var draw_states : Array[DrawState]
var forgery_image_folder : String = "assets/art/paintings/forged"

@onready var reference : Sprite2D = $Reference
@onready var canvas_viewport : SubViewportContainer = $SubViewportContainer
@onready var drawer : Sprite2D = $"SubViewportContainer/SubViewport/Drawer"

var test : bool = false

func _ready() -> void:
	if OS.has_feature("web"):
		forgery_image_folder = "."
	AudioManager.play_music(music_path)
	Camera.set_static()
	header = HeaderTurbo.new()
	Camera.add_ui(header)

	var art_paths : Array[String] = []


	if !test:
		paintings = get_avaliable_paintings()
	else:
		GameState.setup_paintings()
		paintings = GameState.paintings.values()


	if paintings:
		for p in paintings:
			draw_states.append(GameState.get_draw_state(p.id))
			art_paths.append(p.art_path)

		reference.texture = load(paintings[0].art_path)
		drawer.change_draw_state(draw_states[0])


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

func change_painting(index : int, _dropdown: OptionButton) -> void:
	reference.texture = load(paintings[index].art_path)
	drawer.change_draw_state(draw_states[index])

func set_brush_mode(index : int, dropdown: OptionButton) -> void:
	drawer.colour = GameState.brush_mode_to_colour[dropdown.get_item_text(index)]

func set_brush_size(index: int, dropdown: OptionButton):
	drawer.radius = GameState.brush_size_to_int[dropdown.get_item_text(index)]

func settings() -> void:
	drawer.disable()
	Camera.add_ui(SettingsMenu.new(Callable(drawer, "enable")))

func exit() -> void:
	var current_forgery : Image = drawer.viewport.get_texture().get_image()
	drawer.draw_state.image = current_forgery

	for index in paintings.size():
		var forged_painting : Image = draw_states[index].image
		if forged_painting != null:
			var forgery_path : String = "{0}/{1}.png".format({"0" : forgery_image_folder,"1": str(paintings[index].id)})
			forged_painting.save_png(forgery_path)
			paintings[index].forged = true
			paintings[index].forgery_path = forgery_path
			paintings[index].forgery_data = ImageData.new(forged_painting, true)

	var travel_instance = load(travel_scene).instantiate()
	SceneManager.change_scene(self, travel_instance, Callable(travel_instance, "post_fade_out"), true)
