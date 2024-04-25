extends RefCounted

class_name GameState

static var paintings : Dictionary = {}

static func setup_paintings(count : int) -> void:
	for i in range(0, count):
		paintings[i] = PaintingState.new()
	PaintingState.art_paths = AssetsHelper.get_file_paths(AssetsHelper.paintings_folder_path, "png")
	