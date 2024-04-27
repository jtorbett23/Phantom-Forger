extends Sprite2D

var radius : int = 10
var colour : Color = Color.BLACK
var draw_datas : Array = []
var enabled : bool = true

#TODO: Investigate a more peformant solution to drawing

func _draw():
	if draw_datas.size() > 0:
		for data in draw_datas:
			draw_circle(data.pos, data.radius, data.colour)

func _process(_delta) -> void:
	if enabled:
		var mouse_pos : Vector2 = get_global_mouse_position()
		if is_on_canvas(mouse_pos) and Input.is_action_pressed("draw"):
			var draw_data = {"pos": mouse_pos - self.position, "radius": radius, "colour" : colour}
			if not draw_data in draw_datas:
				draw_datas.append(draw_data)
				print(draw_datas.size())
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