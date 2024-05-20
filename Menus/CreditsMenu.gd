extends MenuTurbo

class_name CreditsMenu

func _ready() -> void:
	# Camera.set_static()

	var credits_text = "Art:
	Level & Character
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


func close() -> void:
	self.queue_free()