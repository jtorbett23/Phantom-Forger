extends MenuTurbo

class_name CreditsMenu

func _ready() -> void:
	Camera.set_static()

	var credits_text = "
	Art:
	- Momo
	- delapouite
	- caro-asercion
	- skool
	"
	
	self.set_content("Credits", 
	[	{"name": "Credits", "type": Label, "text": credits_text},
		{"name": "Return", "callback": Callable(self, "close")}
	])


func close() -> void:
	self.queue_free()