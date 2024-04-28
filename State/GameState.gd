extends RefCounted

class_name GameState

static var paintings : Dictionary = {}

static var name_to_colour : Dictionary = {
	"Default" : Color.WHITE,
	"Pink" : Color.LIGHT_PINK,
	"Blue" : Color.LIGHT_BLUE
}

static var game_tint_name : String = "Default"

static func setup_paintings(count : int) -> void:
	PaintingState.free_art_paths = PaintingState.art_paths.duplicate()
	for i in range(0, count):
		paintings[i] = PaintingState.new()
	