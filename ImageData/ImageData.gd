extends RefCounted

class_name ImageData

var size : Vector2i
var bounds_max : Vector2i
var bounds_min : Vector2i
const target_colour = Color.BLACK
const compare_size = Vector2i(300,300)
var shapes : Array[Dictionary] = []
var pixel_dict : Dictionary = {}
var colour_counts : Dictionary = {}
var img : Image

func _init(image: Image):
	
	image.resize(compare_size.x, compare_size.y)
	size = image.get_size()

	var min_target : Vector2i
	var max_target : Vector2i

	var start_time_data_ms : float = Time.get_ticks_msec()
	# generate image data
	for x in range(0, size.x):
		for y in range(0, size.y):
			var colour = image.get_pixel(x,y)
			if(colour != Color.BLACK and colour != Color.WHITE):
				image.set_pixel(x,y, Color.BLACK)
	
	var img_texture : ImageTexture = ImageTexture.create_from_image(image)
	image = img_texture.get_image()
	img = image

	for x in range(0, size.x):
		for y in range(0, size.y):
			var colour = image.get_pixel(x,y)
			pixel_dict[Vector2i(x,y)] = colour
			# find info for bounds - only c
			if colour == target_colour:
				var result = update_target_bounds(Vector2i(x,y), min_target, max_target)
				min_target = result[0]
				max_target = result[1]
				
			# count colours for each pixel type
			if !colour_counts.has(colour):
				colour_counts[colour] = 1
			else:
				colour_counts[colour] += 1

	print("Amount of colours: " + str(colour_counts.size()))
	print(str(colour_counts))
	var end_time_data_ms : float = Time.get_ticks_msec()

	var compare_bounds_min : Vector2i = min_target
	var compare_bounds_max : Vector2i = max_target

	if compare_bounds_min.x > 0:
		compare_bounds_min.x = compare_bounds_min.x - 1
	if compare_bounds_min.y > 0:
		compare_bounds_min.y = compare_bounds_min.y - 1
	if compare_bounds_max.x <= size.x - 2:
		compare_bounds_max.x = compare_bounds_max.x + 2
	if compare_bounds_max.y <= size.y - 2:
		compare_bounds_max.y = compare_bounds_max.y + 2

	var shapes_tracker : Array[Dictionary] = []
	var current_line : Array[Vector2i] = []
	var start_time_shapes_ms : float = Time.get_ticks_msec()
	# loop again only for needed pixels to find shapes
	for x in range(compare_bounds_min.x, compare_bounds_max.x):
		for y in range(compare_bounds_min.y ,compare_bounds_max.y):
			var colour = pixel_dict[Vector2i(x,y)]

			if colour == target_colour:
				current_line.append(Vector2i(x,y))
			if colour != target_colour or y == compare_bounds_max.y - 1:
				if current_line.size() > 0:
					# line has ended
					# if there are no shapes add the line
					if shapes_tracker.size() == 0:
						shapes_tracker.append({"last_x": x, "last_line": current_line, "lines" :current_line})
						current_line = []
					# if there are shapes
					else:
						var connected_shapes : Array = []
						# check what shapes are connected to the current line
						for s: Dictionary in shapes_tracker:
							if (s.last_x == x - 1 or s.last_x == x) and is_line_connected_to_shape(s.last_line, current_line):
								connected_shapes.append(s)
						# if the line is not connected to any shape
						if connected_shapes.size() == 0:
							shapes_tracker.append({"last_x": x, "last_line": current_line, "lines" : current_line})
						else:
							# connect line to all shapes
							var new_shape : Array = current_line
							for s in connected_shapes:
								new_shape.append_array(s.lines)
								shapes_tracker.erase(s)
							shapes_tracker.append({"last_x": x, "last_line": current_line, "lines" : new_shape})
						current_line = []



	var end_time_shapes_ms : float = Time.get_ticks_msec()

	var duration_data : float = (end_time_data_ms - start_time_data_ms) / 1000
	var duration_shape : float = (end_time_shapes_ms - start_time_shapes_ms) / 1000

	print("data gather time" + str(duration_data) + "s")
	print("shape gather time" + str(duration_shape) + "s")
	print("shape count: " + str(shapes_tracker.size()))

	# calculate shape info
	for s in shapes_tracker:
		var shape_min : Vector2i = s.lines[0]
		var shape_max : Vector2i = s.lines[0]
		for point in s.lines:
			var min_max : Array = update_target_bounds(point, shape_min, shape_max)
			shape_min = min_max[0]
			shape_max = min_max[1]
		s["min"] = shape_min
		s["max"] = shape_max
		s["centre"] = (s["max"] + s["min"]) / 2
		shapes.append({"centre" : s["centre"], "points": s.lines})


func is_line_connected_to_shape(shape : Array[Vector2i], line : Array[Vector2i]):
		for point in line:
			if shape.has(point + Vector2i(-1, 0)):
				return true
		return false

func update_target_bounds(pos: Vector2i, minimum: Vector2i, maximum: Vector2i) -> Array:
	if !minimum:
		minimum = pos
	if !maximum:
		maximum = pos
	
	if pos.x > maximum.x:
		maximum.x = pos.x
	
	if pos.y > maximum.y:
		maximum.y = pos.y
	
	if pos.x < minimum.x:
		minimum.x = pos.x
	
	if pos.y < minimum.y:
		minimum.y = pos.y

	return [minimum, maximum]


func compare(ref : ImageData) -> float:

	# TODO: consider content based filtering
	if self.size != ref.size:
		return -1 

	var placement_count : float = 0
	# compare accuracy of individual points
	for point in self.pixel_dict.keys():
		if ref.pixel_dict[point] == self.pixel_dict[point]:
			placement_count += 1

	var placement_pixel_percent : float = (placement_count / self.pixel_dict.size()) * 100
	print("Total pixel placement percent: " + str(placement_pixel_percent) + "%")

	var same_colour_percents : Array = []
	print(self.colour_counts)
	for colour in self.colour_counts.keys():
		if ref.colour_counts.has(colour):
			var diff : float = abs(self.colour_counts[colour] - ref.colour_counts[colour])
			var same_percent : float = 100 - (( diff / self.colour_counts[colour]) * 100)
			print(str(colour) + " same percent: " + str(same_percent) + "%")
			same_colour_percents.append(same_percent)
		else:
			same_colour_percents.append(0)

	var same_colour_percent : float = 0

	for percent in same_colour_percents:
		same_colour_percent += percent
	
	same_colour_percent = same_colour_percent / same_colour_percents.size()

	print("same colours percent: " + str(same_colour_percent) + "%")

	var shape_size_diff_threshold : float = 0.4
	var shape_pos_diff_threshold : float = 50
	var shape_pairs : Array = []
	# BEST CASE - Need to check through all before assigning, might be best to remove worst shape pairs after
	#match up shapes
	if ref.shapes.size() > 0: # This should just fail
		
		var paired_shapes : Array = []
		for s in ref.shapes:
			print("ref size shape size: " + str(s.points.size()))

		for s in self.shapes:
			print("original size shape size: " + str(s.points.size()))
			#var min_size_diff : int = abs(s.points.size() - ref.shapes[0].points.size())
			var min_pos_diff : float =  Vector2(s.centre).distance_to(Vector2(ref.shapes[0].centre))
			var current_pair = null
			for s_ref in ref.shapes:
				if paired_shapes.find(s_ref) == -1:
					var new_size_diff : int = abs(s.points.size() - s_ref.points.size())
					var new_pos_diff : float = Vector2(s.centre).distance_to(Vector2(s_ref.centre))
					var size_diff_ratio : float = new_size_diff / s.points.size()
					# check if positions are within a range
					if Vector2(s.centre).distance_to(Vector2(s_ref.centre)) < shape_pos_diff_threshold and new_pos_diff <= min_pos_diff:
						if  size_diff_ratio < shape_size_diff_threshold: # new_size_diff <= min_size_diff and
								min_pos_diff = new_pos_diff
								current_pair = s_ref

			if(current_pair != null):
				shape_pairs.append([s, current_pair])
				paired_shapes.append(current_pair)
			current_pair = null

		print("Paired shapes: " + str(shape_pairs.size()))
		for pair in shape_pairs:
			var size_diff : int = abs(pair[0].points.size() - pair[1].points.size())
			var pos_diff : Vector2i = abs(pair[0].centre - pair[1].centre)
			print("shape size diff: " + str(size_diff))
			print("shape pos diff: " + str(pos_diff))
	
	var diff_shapes : float = abs(self.shapes.size() - shape_pairs.size())
	var shape_count_percent : float = 100 - ( diff_shapes / self.shapes.size() * 100)
	print("Shape count same percent : " + str(shape_count_percent) + "%")

	var final_percent : float = (shape_count_percent + placement_pixel_percent + same_colour_percent) / 3

	if shape_pairs.size() == 0: # TODO: Check the number of paired shapes
		final_percent = 0
	print("final score percent: " + str(final_percent) + "%")

	return 1


func visualise_shape(image_save_id : String):
	var rng = RandomNumberGenerator.new()
	# set pixels for shape example
	for s in shapes:
		var r = rng.randf()
		var g = rng.randf()
		var b = rng.randf()
		var a = rng.randf_range(0.5, 1.0)
		for point in s.points:
			img.set_pixelv(point, Color(r,g,b,a))
		img.set_pixelv(s.centre, Color.BLACK)

	# set pixels for bounding box
	for x in range(0, size.x):
		for y in range(0, size.y):
			if x == bounds_min.x or x == bounds_max.x:
				img.set_pixelv(Vector2i(x,y), Color.REBECCA_PURPLE)	
			if y  == bounds_min.y or y == bounds_max.y:
				img.set_pixelv(Vector2i(x,y), Color.REBECCA_PURPLE)	

	# print updated image
	var image_path = "./test/WOW" + image_save_id + ".png"
	img.save_png(image_path)



