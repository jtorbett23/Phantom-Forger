extends Interactable

@export var connection : Interactable

func interact(target = null) -> void:
	target.position.x = connection.global_position.x
	
