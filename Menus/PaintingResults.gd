extends Control

const img_size : Vector2 = Vector2i(65,65)

const canvas_path : String = "res://assets/art/canvas.png"
@onready var no_forges : Label = $NoForges


func _ready():
	var next_container_start_y : int = 0
	var next_container_start_y_increase : int = img_size.y + 10
	var forged_count : int  = 0
	for p in GameState.paintings.values():
		if p.forged:
			var container : Control = Control.new()
			container.position.y = next_container_start_y
			next_container_start_y += next_container_start_y_increase
			self.add_child(container)

			var original_texture : Texture2D = load(p.art_path)
			var original_image : Image = original_texture.get_image()
			original_image.resize(img_size.x, img_size.y)
			var original : Sprite2D = Sprite2D.new()
			original.name = "Original"
			original.texture = ImageTexture.create_from_image(original_image)
			container.add_child(original)
			
			forged_count += 1
			var forged_image = Image.load_from_file(p.forgery_path)
			forged_image.resize(img_size.x, img_size.y)
			var forged : Sprite2D = Sprite2D.new()
			forged.texture = ImageTexture.create_from_image(forged_image)
			forged.position.x = img_size.x + 20
			container.add_child(forged)
			# else:
			# 	var forged_texture : Texture2D = load(canvas_path)
			# 	var forged_image : Image = forged_texture.get_image()
			# 	forged_image.resize(img_size.x, img_size.y)
			# 	var forged : Sprite2D = Sprite2D.new()
			# 	forged.name = "Forged"
			# 	forged.texture = ImageTexture.create_from_image(forged_image)
			# 	forged.position.x = img_size.x + 20
			# 	container.add_child(forged)
			
			var accuracy_label : Label = Label.new()
			accuracy_label.name = "Accuracy"
			accuracy_label.position.x = img_size.x * 2
			accuracy_label.position.y = -(img_size.y / 5)
			accuracy_label.text = "Accuracy: " + str(round(p.accuracy)) + "%"
			container.add_child(accuracy_label)
	
	if forged_count == 0:
		no_forges.show()







