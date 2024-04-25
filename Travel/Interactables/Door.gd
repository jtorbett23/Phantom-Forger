extends Interactable

@export var connection : Interactable

func interact(target = null) -> void:
	Camera.fade(Callable(self, "move_player").bind(target), Callable(target, "enable_player"))

func move_player(target) -> void:
	target.position.x = connection.global_position.x
	if(connection.name == "Office-Exit"):
		owner.set_office_limits()
	elif(connection.name == "Office-Entrance"):
		owner.set_halls_limits()	
