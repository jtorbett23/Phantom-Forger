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
	
	art.texture = load(state.art_path)

func interact(target = null) -> void:
	var question: String = "Are you sure you want to take this painting?\n If you do you must replace it with a forgery."
	var popup = PopupTurbo.new(question, PopupTurbo.QUESTION, Callable(self, "remove_original").bind(target),  Callable(target, "enable_player"))
	Camera.add_ui(popup)

func remove_original(target = null) -> void:
	target.enable_player()
	print("removing original painting")


