extends RefCounted

class_name PaintingState 

static var art_paths : Array[String] = AssetsHelper.get_file_paths(AssetsHelper.paintings_folder_path, "png")
static var count : int = 0

var frame_id : int = 1
var art_path : String 
var placed : bool = true
var forged : bool = false

var rng = RandomNumberGenerator.new()

func _init() -> void:
	frame_id = 	rng.randi_range(1, 3)

	var index : int = rng.randi_range(0, art_paths.size() - 1)
	art_path = art_paths[index]
	art_paths.pop_at(index)


