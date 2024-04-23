extends Area2D

class_name Interactable

func _ready() -> void:
	self.connect("body_exited", on_body_exit)
	self.connect("body_entered", on_body_enter)

func on_body_enter(body) -> void:
	if(body.name == "Player"):
		body.set_interact(self)

func on_body_exit(body) -> void:
	if(body.name == "Player"):
		body.set_interact(null)

func interact(_target = null) -> void:
	pass