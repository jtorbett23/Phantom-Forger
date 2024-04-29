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

	var img_score : float = 0
	var img_score_max : float = total_pixels

	var centre = Vector2(256,256)
	var edge = Vector2(0,0)
	var max_dist = centre.distance_to(edge)
	var average_dist_factor = 1 - (centre.distance_to(Vector2(128, 128)) / max_dist)


	for x in range(0, img1_size.x):
		for y in range(0, img1_size.y):
			#using pixel by pixel comparison
			var distance_factor = 1 - (centre.distance_to(Vector2(x,y)) / max_dist)
			var colour_1 = image1.get_pixel(x,y)
			var colour_2 = image2.get_pixel(x,y)
			if colour_1 == colour_2:
				if(colour_1 == Color.WHITE):
					white_matches += 1
					img_score += (1 * distance_factor)
				elif(colour_1 == Color.BLACK):	
					black_matches += 1
					img_score += (3 * distance_factor)
			if colour_1 != colour_2:
				if(colour_1 == Color.WHITE):
					img_score -= (2 * distance_factor)
				elif(colour_1 == Color.BLACK):	
					img_score -= (4 * distance_factor)
			if colour_1 == Color.WHITE:
				white_pixels_1 += 1
			elif colour_1 == Color.BLACK:
				black_pixels_1 += 1
			if colour_2 == Color.WHITE:
				white_pixels_2 += 1
			elif colour_2 == Color.BLACK:
				black_pixels_2 += 1

	var img_score_percentage = (img_score / (((black_pixels_1 * 2) + white_pixels_1) * average_dist_factor)) * 100

	var weighting_black : float = black_pixels_1 / total_pixels
	var weighting_white : float = white_pixels_1 / total_pixels

	# print("Weighting black: " + str(weighting_black))
	# print("Weighting white: " + str(weighting_white))

	# calculate match of pixel colours %
	var black_match_percent : float = (black_matches / black_pixels_1) * 100
	var white_match_percent : float = (white_matches / white_pixels_1) * 100
	var weighted_combined_match_percent : float = ( (black_match_percent / weighting_white) + (white_match_percent * weighting_white)) / 2
	var combined_match_percent : float = ((black_matches + white_matches) / total_pixels) * 100
	
	# print("black pixel colour matches percentage: " + str(black_match_percent) + "%")
	# print("white pixel colour matches percentage: " + str(white_match_percent) + "%")
	print("combined pixel colour matches percentage: " + str(combined_match_percent) + "%")
	print("weighted combined pixel colour matches percentage: " + str(weighted_combined_match_percent) + "%")
	# print("-------------")

	var diff_black : float = abs(black_pixels_1 - black_pixels_2)
	var diff_white : float = abs(white_pixels_1 - white_pixels_2)

	# var raw_colour_score : float = total_pixels - diff_black - diff_white
	# var weighted_colour_score : float = total_pixels - (diff_black / black_pixel_weight) - (diff_white / white_pixel_weight)
	# var colour_score_percentage : float = (raw_colour_score / total_pixels) * 100
	# var weighted_colour_score_percentage : float = (weighted_colour_score / total_pixels) * 100

	var black_diff_colour_percent : float = (diff_black / black_pixels_1) * 100
	var white_diff_colour_percent: float = (diff_white / white_pixels_1) * 100
	var weighted_black_diff_colour_percent : float = ((diff_black / weighting_white) / black_pixels_1) * 100
	var weighted_white_diff_colour_percent: float = (diff_white * weighting_white / white_pixels_1) * 100
	var colour_diff_percentage : float = (white_diff_colour_percent + black_diff_colour_percent) / 2
	var weighted_colour_diff_percentage : float = ((weighted_white_diff_colour_percent) + weighted_black_diff_colour_percent) / 2
	# print("pixel colour percentage: " + str(colour_score_percentage) + "%")
	# print("pixel colour percentage weighted: " + str(weighted_colour_score_percentage) + "%")

	# print("black pixel diff colour percentage: " + str(black_diff_colour_percent) + "%")
	# print("white pixel diff colour percentage: " + str(white_diff_colour_percent) + "%")
	print("combined pixel diff colour percentage: " + str(colour_diff_percentage) + "%")
	# print("weighted black pixel diff colour percentage: " + str(weighted_black_diff_colour_percent) + "%")
	# print("weighted white pixel diff colour percentage: " + str(weighted_white_diff_colour_percent) + "%")
	print("weighted combined pixel diff colour percentage: " + str(weighted_colour_diff_percentage) + "%")
	# print("-------------")

	# var final_score_percentage : float = (colour_score_percentage + combined_match_percent) / 2
	# var weighted_final_score_percentage : float = ((weighted_colour_score_percentage) + (percent_combined_match) ) / 2 

	var final_score_percentage : float = ((100 - colour_diff_percentage) + combined_match_percent) / 2
	var weighted_final_score_percentage : float = ((100 - weighted_colour_diff_percentage) + (weighted_combined_match_percent)) / 2
	var final_score_percentage_img_score : float = ((100 - colour_diff_percentage) + combined_match_percent + (img_score_percentage * 2)) / 4
	var weighted_final_score_percentage_img_score : float = ((100 - weighted_colour_diff_percentage) + (weighted_combined_match_percent) + (img_score_percentage * 2)) / 4
	
	print("image score percentage: " + str(img_score_percentage))
	print("final similarity score: " + str(final_score_percentage) + "%")
	print("final similarity score + img_score: " + str(final_score_percentage_img_score) + "%")
	print("final similarity score weigthed: " + str(weighted_final_score_percentage) + "%")
	print("final similarity score weigthed + img_score: " + str(weighted_final_score_percentage_img_score) + "%")
	print("-------------")