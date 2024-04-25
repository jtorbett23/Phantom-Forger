extends RefCounted

class_name AssetsHelper

static var paintings_folder_path = "res://assets/art/paintings" 

static func setup_paintings() -> void:
	var painting_paths = get_file_paths(paintings_folder_path, "png")

	for path in painting_paths:
		var text = load(path)
		var image = text.get_image()
		var size : Vector2 = image.get_size()

		for w in size.x:
			for h in size.y: 
				if(image.get_pixel(w,h) != Color.WHITE):
					image.set_pixel(w,h,Color.BLACK)
		image.save_png(path)
			

static func get_file_paths(path, extension) -> Array[String]:
	var dir = DirAccess.open(path)
	var file_paths : Array[String] = []
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir() and file_name.get_extension() == extension:
				file_paths.append(path + "/" + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return file_paths
