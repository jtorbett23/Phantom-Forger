extends RefCounted

class_name GameState

static var paintings_per_level = 8

static var paintings : Dictionary = {}

static var draw_states : Dictionary 

static var name_to_colour : Dictionary = {
	"Default" : Color.WHITE,
	"Pink" : Color.LIGHT_PINK,
	"Blue" : Color.LIGHT_BLUE,
}

static var brush_mode_to_colour : Dictionary = {
	"Draw" : Color.BLACK,
	"Erase" : Color.WHITE
}

static var brush_size_to_int : Dictionary = {
	"5px" : 5,
	"10px" : 10,
	"20px" : 20,
	"50px" : 50
}

static var game_tint_name : String = "Default"

static func get_draw_state(draw_id : int) -> DrawState:
	if !draw_states.has(draw_id):
		draw_states[draw_id] = DrawState.new()
	return draw_states[draw_id]



static func setup_paintings() -> void:
	PaintingState.free_art_paths = PaintingState.art_paths.duplicate()
	for i in range(0, paintings_per_level):
		paintings[i] = PaintingState.new(i)
	draw_states = {}
	