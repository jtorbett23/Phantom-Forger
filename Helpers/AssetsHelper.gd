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

static func calculate_image_similarity(image1: Image , image2 : Image):
	var img1_size : Vector2i = image1.get_size()

	if img1_size!= image2.get_size():
		print("Image are not same size unable to compare")
		return -1 

	var total_pixels : float = img1_size.x * img1_size.y
	var white_matches : float = 0
	var black_matches : float = 0
	var black_pixels_1 : int = 0
	var white_pixels_1 : int = 0
	var black_pixels_2 : int = 0
	var white_pixels_2 : int = 0

	for x in range(0, img1_size.x):
		for y in range(0, img1_size.y):
			#using pixel by pixel comparison
			var colour_1 = image1.get_pixel(x,y)
			var colour_2 = image2.get_pixel(x,y)
			if colour_1 == colour_2:
				if(colour_1 == Color.WHITE):
					white_matches += 1
				elif(colour_1 == Color.BLACK):	
					black_matches += 1
			if colour_1 == Color.WHITE:
				white_pixels_1 += 1
			elif colour_1 == Color.BLACK:
				black_pixels_1 += 1
			if colour_2 == Color.WHITE:
				white_pixels_2 += 1
			elif colour_2 == Color.BLACK:
				black_pixels_2 += 1

	# calculate match of pixel colours %
	var black_match_percent : float = (black_matches / black_pixels_1) * 100
	var white_match_percent : float = (white_matches / white_pixels_1) * 100
	var combined_match_percent : float = ((black_matches + white_matches) / total_pixels) * 100
	
	print("black pixel colour matches percentage: " + str(black_match_percent) + "%")
	print("white pixel colour matches percentage: " + str(white_match_percent) + "%")
	print("combined pixel colour matches percentage: " + str(combined_match_percent) + "%")
	print("-------------")

	var diff_black : int = abs(black_pixels_1 - black_pixels_2)
	var diff_white : int = abs(white_pixels_1 - white_pixels_2)
	var weighting_black : float = black_pixels_1 / total_pixels
	var weighting_white : float = white_pixels_1 / total_pixels
	var black_pixel_weight : float = 1
	var white_pixel_weight : float = weighting_white

	print("Weighting black: " + str(white_pixel_weight))
	print("Weighting white: " + str(black_pixel_weight))

	var raw_colour_score : float = total_pixels - diff_black - diff_white
	var weighted_colour_score : float = total_pixels - (diff_black / black_pixel_weight) - (diff_white / white_pixel_weight)
	var colour_score_percentage : float = (raw_colour_score / total_pixels) * 100
	var weighted_colour_score_percentage : float = (weighted_colour_score / total_pixels) * 100

	print("pixel colour percentage: " + str(colour_score_percentage) + "%")
	print("pixel colour percentage weighted: " + str(weighted_colour_score_percentage) + "%")
	print("-------------")

	var final_score_percentage : float = (colour_score_percentage + combined_match_percent) / 2
	var weighted_final_score_percentage : float = ((weighted_colour_score_percentage) + (combined_match_percent) ) / 2 

	print("final similarity score: " + str(final_score_percentage) + "%")
	print("final similarity score weigthed: " + str(weighted_final_score_percentage) + "%")
	print("-------------")