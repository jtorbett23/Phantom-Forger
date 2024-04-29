extends Sprite2D

var radius : int = 10
var colour : Color = Color.BLACK
var draw_state : DrawState
var enabled : bool = true
var redraw_limit : int = 200

@onready var viewport : SubViewport = self.get_parent()
@onready var original_canvas : Image = self.texture.get_image()

func _draw() -> void:
	if draw_state.datas.size() > 0:
		var start_index : int = 0
		if draw_state.datas.size() > redraw_limit:
			start_index = draw_state.datas.size() - redraw_limit
		for i in range(start_index, start_index + redraw_limit):
			if i > draw_state.datas.size() - 1:
				return
			var data : Dictionary = draw_state.datas[i]

			if data.has("pos"):
				draw_circle(data.pos, data.radius, data.colour)

func draw_canvas_redrawing(pos : Vector2i):
		var draw_data = {"pos": pos, "radius": radius, "colour" : colour}
		if not draw_data in draw_state.datas:
			draw_state.datas.append(draw_data)
			queue_redraw()
			if (draw_state.datas.size() % redraw_limit) == 0 and draw_state.datas.size() >= redraw_limit:
				draw_state.datas[draw_state.datas.size() -1]["image"] = self.texture.get_image()
				var new_image : Image = viewport.get_texture().get_image()
				self.texture = ImageTexture.create_from_image(new_image)

func _process(_delta) -> void:
	if enabled:
		var pos : Vector2i = get_local_mouse_position()
		if is_on_canvas(pos) and Input.is_action_pressed("draw"):
			draw_canvas_redrawing(pos)
		
		elif Input.is_action_pressed("undo"):
			if draw_state.datas.size() > 0:
				var data = draw_state.datas.pop_back()
				if data and data.has("image"):
					if draw_state.datas.size() == 0 and draw_state.prev_datas.size() > 0:
						draw_state.datas = draw_state.prev_datas.pop_back()
					else:
						self.texture = ImageTexture.create_from_image(data["image"])
				queue_redraw()
			elif draw_state.prev_datas.size() > 0:
				draw_state.datas = draw_state.prev_datas.pop_back()
				var data = draw_state.datas[draw_state.datas.size() - 1]
				if data and data.has("image"):
					self.texture = ImageTexture.create_from_image(data["image"])
				queue_redraw()

		elif Input.is_action_just_pressed("clear"):
			draw_state.prev_datas.append(draw_state.datas)
			draw_state.datas = [{"image": original_canvas}]
			self.texture = ImageTexture.create_from_image(original_canvas)

func change_draw_state(new_state: DrawState) -> void:
	#save image of current drawing
	if draw_state:
		draw_state.image = viewport.get_texture().get_image()

	#handle new draw state
	draw_state = new_state
	if draw_state.datas.size() > redraw_limit:
		@warning_ignore("integer_division")
		var redraw_count : int = floor(draw_state.datas.size() / redraw_limit)
		self.texture = ImageTexture.create_from_image(draw_state.datas[(redraw_count * redraw_limit) - 1].image)
	else:
		self.texture = ImageTexture.create_from_image(original_canvas)


	queue_redraw()

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
