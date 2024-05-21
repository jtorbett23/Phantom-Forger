extends MenuTurbo

class_name CreditsMenu

func _init():
	title_percentage_from_top = GameState.ui_title_from_top
	button_min_size = Vector2(140,30)
	super._init("res://assets/Themes/ui-forger.png")


func _ready() -> void:
	# Camera.set_static()

	var credits_text = "
	Level & Character Art
	- Momo

	Paintings
	- Lorc, http://lorcblog.blogspot.com
	- Delapouite - https://delapouite.com
	- Caro Asercion
	- Skoll
	"
	
	self.set_content("Credits", 
	[	{"name": "Credits", "type": Label, "text": credits_text},
		{"name": "Return", "callback": Callable(self, "close")}
	])

	theme = load("assets/Themes/ui.tres")
func close() -> void:
	self.queue_free()