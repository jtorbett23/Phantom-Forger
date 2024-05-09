extends RefCounted

class_name PaintingState 

static var art_paths : Array[String] = ["res://assets/art/paintings/wood-axe.png", "res://assets/art/paintings/rabbit.png", "res://assets/art/paintings/plunger.png", "res://assets/art/paintings/sea-star.png", "res://assets/art/paintings/bunny-slippers.png", "res://assets/art/paintings/hook.png", "res://assets/art/paintings/spade.png", "res://assets/art/paintings/tortoise.png", "res://assets/art/paintings/weight.png", "res://assets/art/paintings/axolotl.png", "res://assets/art/paintings/whale-tail.png", "res://assets/art/paintings/anvil.png", "res://assets/art/paintings/sickle.png", "res://assets/art/paintings/pig.png", "res://assets/art/paintings/koala.png", "res://assets/art/paintings/spanner.png"]
# TODO: export art paths prior  via AssetHelper
# static var art_paths : Array[String] = AssetsHelper.get_file_paths(AssetsHelper.paintings_folder_path, "png")
static var free_art_paths : Array[String] = art_paths.duplicate()
static var count : int = 0

var id : int
var frame_id : int = 1
var art_path : String
var art_data : ImageData
var forgery_path : String
var forgery_data : ImageData
var placed : bool = true
var forged : bool = false
var accuracy : float = 0
var value : int

var rng = RandomNumberGenerator.new()

func _init(painting_id: int) -> void:
	self.id = painting_id
	self.frame_id = rng.randi_range(1, 3)
	self.value = GameState.value_base + GameState.rng.randi_range(0, GameState.value_range)
	var index : int = rng.randi_range(0, free_art_paths.size() - 1)
	self.art_path = free_art_paths[index]
	free_art_paths.pop_at(index)


