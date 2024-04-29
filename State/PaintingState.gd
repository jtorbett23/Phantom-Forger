extends RefCounted

class_name PaintingState 

# static var art_paths : Array[String] = ["res://assets/art/paintings/rabbit.png", "res://assets/art/paintings/sea-star.png", "res://assets/art/paintings/bunny-slippers.png", "res://assets/art/paintings/tortoise.png", "res://assets/art/paintings/axolotl.png", "res://assets/art/paintings/whale-tail.png", "res://assets/art/paintings/pig.png", "res://assets/art/paintings/koala.png"]

# TODO: export art paths prior 
static var art_paths : Array[String] = AssetsHelper.get_file_paths(AssetsHelper.paintings_folder_path, "png")
static var free_art_paths : Array[String] = art_paths.duplicate()
static var count : int = 0

var id : int
var frame_id : int = 1
var art_path : String
var forgery_path : String
var placed : bool = true
var forged : bool = false
var accuracy : float = 0.0

var rng = RandomNumberGenerator.new()

func _init(painting_id: int) -> void:
	self.id = painting_id
	self.frame_id = rng.randi_range(1, 3)

	var index : int = rng.randi_range(0, free_art_paths.size() - 1)
	self.art_path = free_art_paths[index]
	free_art_paths.pop_at(index)


