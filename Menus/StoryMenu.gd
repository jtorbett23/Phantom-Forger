extends MenuTurbo

class_name StoryMenu

var travel_scene : String = "res://Travel/travel.tscn"

var close_callback : Callable

func _init(on_close_callback : Callable = Callable()):
	super()
	self.close_callback = on_close_callback

func _ready() -> void:
	Camera.set_static()

	var story_text = "In this game you play as Herb, a security guard at a museum. Herb has some big debts, and needs to forge some art to pay them. On the last day of the month they switch out the art, which is the perfect time to strike.
	
	Be careful with the forgeries or the automated security may trigger. Good luck :)"
	
	self.set_content("Story", 
	[	{"name": "Story", "type": Label, "min_size": Vector2(500, 30), "wrap": true, "text": story_text},
		{"name": "Proceed", "callback": Callable(self, "proceed")}
	])


func proceed() -> void:
	var travel_instance = load(travel_scene).instantiate()
	SceneManager.change_scene(self, travel_instance, Callable(travel_instance, "post_fade_out"), true)
	if !close_callback.is_null():
		close_callback.call()