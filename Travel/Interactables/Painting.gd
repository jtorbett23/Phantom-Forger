extends Interactable

const frame_offsets : Dictionary = {1 : Vector2(20,10), 2 : Vector2(20,50), 3 : Vector2(0,0)}
const painting_size : Vector2 = Vector2(325,325)

@onready var frame : Sprite2D = $Frame
@onready var art : Sprite2D = $Art

var id : int
var state : PaintingState

func _ready():
	super()

	id = PaintingState.count
	PaintingState.count += 1
	state = GameState.paintings[id]
	var art_size : Vector2 = art.texture.get_image().get_size()
	art.scale = Vector2(painting_size.x / art_size.x, painting_size.y / art_size.y)

	if(state.frame_id != 1):
		var frame_path = "res://assets/art/paintings/frames/frame-{0}.png".format({"0" : str(state.frame_id)})
		frame.texture = load(frame_path)
		frame.position = frame_offsets[state.frame_id]
	
	if state.placed:
		if !state.forged:
			art.texture = load(state.art_path)
		else:
			var image = Image.load_from_file(state.forgery_path)
			art.texture = ImageTexture.create_from_image(image)
	else:
		art.visible = false

func interact(target = null) -> void:
	if(state.placed == true and state.forged == false):
		var question : String = "Are you sure you want to take this painting?\n If you do you must replace it with a forgery."
		var popup = PopupTurbo.new(question, PopupTurbo.QUESTION, Callable(target, "enable_player"), Callable(self, "remove_original").bind(target))
		Camera.add_ui(popup)
	elif(state.placed == false and state.forged == false):
		var message : String = "You still need to make a forgery for this painting."
		var popup = PopupTurbo.new(message, PopupTurbo.MESSAGE, Callable(target, "enable_player"))
		Camera.add_ui(popup)
	elif(state.placed == false and state.forged == true):
		var question : String = "Are you sure you want to place this forgery?\n You cannot change it after."
		var popup = PopupTurbo.new(question, PopupTurbo.QUESTION, Callable(target, "enable_player"), Callable(self, "place_forgery").bind(target))
		Camera.add_ui(popup)
	elif(state.placed == true and state.forged == true):
		var message : String = "This painting has been forged and cannot be changed."
		var popup = PopupTurbo.new(message, PopupTurbo.MESSAGE, Callable(target, "enable_player"))
		Camera.add_ui(popup)

func remove_original(target = null) -> void:
	target.enable_player()
	art.visible = false
	state.placed = false

func place_forgery(target = null):
	target.enable_player()
	var forged_image = Image.load_from_file(state.forgery_path)
	var original_texture : Texture2D = load(state.art_path)
	var original_image : Image = original_texture.get_image()
	calculate_accuracy(original_image, forged_image)
	art.texture = ImageTexture.create_from_image(forged_image)
	art.visible = true
	state.placed = true

	

func calculate_accuracy(original : Image, forgery : Image):
	print(original)
	print(forgery)
	# find a way to compare the images pixels

	# save the accuracy to the painting state
