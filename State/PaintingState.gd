extends RefCounted

class_name PaintingState 

static var art_paths : Array[String] = AssetsHelper.get_file_paths(AssetsHelper.paintings_folder_path, "png")
static var free_art_paths : Array[String] = art_paths.duplicate()
static var count : int = 0

var frame_id : int = 1
var art_path : String
var forgery_path : String
var placed : bool = true
var forged : bool = false

var rng = RandomNumberGenerator.new()

func _init() -> void:
	frame_id = 	rng.randi_range(1, 3)

	var index : int = rng.randi_range(0, free_art_paths.size() - 1)
	art_path = free_art_paths[index]
	free_art_paths.pop_at(index)


