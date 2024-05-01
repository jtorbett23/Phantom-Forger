extends RefCounted

class_name ImageData

var size : Vector2i
var bounds_max : Vector2i
var bounds_min : Vector2i
const target_colour = Color.BLACK


func _init(image: Image):
	
	size = image.get_size()

	var colour_counts : Dictionary = {}
	var image_dict : Dictionary
	var min_target : Vector2i
	var max_target : Vector2i

	# during these steps 
	# if pixel is of target colour -> add pixel to line
	# else 
	#	if shapes empty -> add line to shapes
	#   else
	#		for shape in shapes
	#			if line connected to shape
	#				remove all conneceted shapes and combine -> place back in shapes
	#		if not connected to any -> add to shapes
	#   	clear current line

	var shapes : Array[Array] = []
	var current_line : Array[Vector2i] = []

	# generate image data
	for x in range(0, size.x):
		for y in range(0, size.y):
			var colour = image.get_pixel(x,y)

			# find info for bounds
			if colour == target_colour:
				var result = update_target_bounds(Vector2i(x,y), min_target, max_target)
				min_target = result[0]
				max_target = result[1]
				# add to current line
				current_line.append(Vector2i(x,y))
			else:
				if current_line.size() > 0:
					# line has ended
					# if there are no shapes add the line
					if shapes.size() == 0:
						shapes.append(current_line)
						current_line = []
					# if there are shapes
					else:
						var connected_shapes : Array = []
						# check what shapes are connected to the current line
						for s: Array[Vector2i] in shapes:
							if is_line_connected_to_shape(s, current_line):
								connected_shapes.append(s)
						# if the line is not connected to any shape
						if connected_shapes.size() == 0:
							shapes.append(current_line)
						else:
							# connect line to all shapes
							var new_shape : Array = current_line
							for s in connected_shapes:
								new_shape.append_array(s)
								shapes.erase(s)
							shapes.append(new_shape)
						current_line = []

			# setup dict for shape finding
			image_dict[Vector2i(x,y)] = colour

			# count colours for each pixel type
			if !colour_counts.has(colour):
				colour_counts[colour] = 1
			else:
				colour_counts[colour] += 1

	@warning_ignore("integer_division")
	bounds_max = Vector2i(
		size.x - (size.x - max_target.x) / 2,
		size.y - (size.y - max_target.y) / 2
	)

	@warning_ignore("integer_division")
	bounds_min = Vector2i(
		min_target.x / 2,
		min_target.y / 2
	)
	
	var rng = RandomNumberGenerator.new()
	# set pixels for shape example
	for s in shapes:
		var r = rng.randf()
		var g = rng.randf()
		var b = rng.randf()
		var a = rng.randf_range(0.5, 1.0)
		for point in s:
			image.set_pixelv(point, Color(r,g,b,a))



	# set pixels for bounding box
	for x in range(0, size.x):
		for y in range(0, size.y):
			if x == bounds_min.x or x == bounds_max.x:
				image.set_pixelv(Vector2i(x,y), Color.REBECCA_PURPLE)	
			if y  == bounds_min.y or y == bounds_max.y:
				image.set_pixelv(Vector2i(x,y), Color.REBECCA_PURPLE)	

	# print updated image 
	image.save_png("./WOW.png")


func is_line_connected_to_shape(shape : Array[Vector2i], line : Array[Vector2i]):
		for point in line:
			if (point + Vector2i(-1, 0)) in shape:
				return true
		return false


func update_target_bounds(pos: Vector2i, min_target: Vector2i, max_target: Vector2i) -> Array:
	if !min_target:
		min_target = pos
	if !max_target:
		max_target = pos
	
	if pos.x > max_target.x:
		max_target.x = pos.x
	
	if pos.y > max_target.y:
		max_target.y = pos.y
	
	if pos.x < min_target.x:
		min_target.x = pos.x
	
	if pos.y < min_target.y:
		min_target.y = pos.y

	return [min_target, max_target]


func find_shapes(image_array: Array[Array]):

	pass
	


func is_valid_position(pos: Vector2i) -> bool:
	if pos.x < 0 or pos.y < 0:
		return false
	if pos.x > size.x - 1 or pos.y > size.y - 1:
		return false
	return true

