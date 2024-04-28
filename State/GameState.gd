extends RefCounted

class_name GameState

static var paintings : Dictionary = {}

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

static func setup_paintings(count : int) -> void:
	PaintingState.free_art_paths = PaintingState.art_paths.duplicate()
	for i in range(0, count):
		paintings[i] = PaintingState.new()
	