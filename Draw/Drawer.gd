extends Sprite2D

var radius : int = 10
var colour : Color = Color.BLACK
var draw_datas : Array[Dictionary] = []
var prev_draw_datas : Array[Array] = []
var enabled : bool = true
var redraw_limit : int = 200

@onready var viewport : SubViewport = self.get_parent()
@onready var original_canvas : Image = self.texture.get_image()

#TODO: add brush size, add current image, add saving forgery

func _draw() -> void:
	if draw_datas.size() > 0:
		var start_index : int = 0
		if draw_datas.size() > redraw_limit:
			start_index = draw_datas.size() - redraw_limit
		for i in range(start_index, start_index + redraw_limit):
			if i > draw_datas.size() - 1:
				return
			var data : Dictionary = draw_datas[i]

			if data.has("pos"):
				draw_circle(data.pos, data.radius, data.colour)

func draw_canvas_redrawing(pos : Vector2i):
		var draw_data = {"pos": pos, "radius": radius, "colour" : colour}
		if not draw_data in draw_datas:
			draw_datas.append(draw_data)
			queue_redraw()
			if (draw_datas.size() % redraw_limit) == 0 and draw_datas.size() >= redraw_limit:
				draw_datas[draw_datas.size() -1]["image"] = self.texture.get_image()
				var new_image : Image = viewport.get_texture().get_image()
				self.texture = ImageTexture.create_from_image(new_image)

func _process(_delta) -> void:
	if enabled:
		var pos : Vector2i = get_local_mouse_position()
		if is_on_canvas(pos) and Input.is_action_pressed("draw"):
			draw_canvas_redrawing(pos)
		
		elif Input.is_action_pressed("undo"):
			if draw_datas.size() > 0:
				var data = draw_datas.pop_back()
				if data and data.has("image"):
					if draw_datas.size() == 0 and prev_draw_datas.size() > 0:
						draw_datas = prev_draw_datas.pop_back()
					else:
						self.texture = ImageTexture.create_from_image(data["image"])
				queue_redraw()
			elif prev_draw_datas.size() > 0:
				draw_datas = prev_draw_datas.pop_back()
				var data = draw_datas[draw_datas.size() - 1]
				if data and data.has("image"):
					self.texture = ImageTexture.create_from_image(data["image"])
				queue_redraw()

		elif Input.is_action_just_pressed("clear"):
			prev_draw_datas.append(draw_datas)
			draw_datas = [{"image": original_canvas}]
			self.texture = ImageTexture.create_from_image(original_canvas)

func is_on_canvas(mouse_pos : Vector2) -> bool:
	var min_pos : Vector2 = self.position
	var max_pos : Vector2 = min_pos + self.texture.get_size()
	#within min
	if (mouse_pos.x > min_pos.x) and (mouse_pos.y > min_pos.y):
		#within max
		if (mouse_pos.x < max_pos.x) and (mouse_pos.y < max_pos.y):
			return true
	return false

func enable() -> void:
	enabled = true

func disable() -> void:
	enabled = false