extends Sprite2D

var radius : int = 20
var colour : Color = Color.BLACK
var draw_datas : Array[Dictionary] = []
var enabled : bool = true
var redraw_limit : int = 200

@onready var viewport : SubViewport = self.get_parent()

#TODO: track redraws to undo, add eraser, add clear 

func _draw() -> void:
	if draw_datas.size() > 0:
		for i in range(0, redraw_limit):
			if i > draw_datas.size() - 1:
				return
			var data : Dictionary = draw_datas[draw_datas.size() - 1 - i]
			draw_circle(data.pos, data.radius, data.colour)

func draw_canvas_redrawing(pos : Vector2i):
		var draw_data = {"pos": pos, "radius": radius, "colour" : colour}
		if not draw_data in draw_datas:
			draw_datas.append(draw_data)
			queue_redraw()
			if draw_datas.size() % (redraw_limit) and draw_data.size() > 0:
				print(viewport.name)
				var new_image : Image = viewport.get_texture().get_image()
				self.texture = ImageTexture.create_from_image(new_image)

func _process(_delta) -> void:
	if enabled:
		var pos : Vector2i = get_local_mouse_position()
		if is_on_canvas(pos) and Input.is_action_pressed("draw"):
			draw_canvas_redrawing(pos)

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