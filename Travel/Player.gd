extends CharacterBody2D

# Godot Nodes
@onready var sprite : Sprite2D = $Sprite
@onready var action_marker : Sprite2D = $ActionMarker
@onready var collision_shape : CollisionShape2D = $CollisionShape2D

# Constants
@export var player_speed : int = 600
var rotate_time : float = 0.35
var rotate_timer : float = 0
var rotate_value : int = 15
var col_shape_flip_offset : float
var action_marker_flip_offset : float
var interactable : Interactable
@export var enabled : bool = false #TODO: Revert export

func _ready():
	sprite.modulate = GameState.herb_colour
	col_shape_flip_offset = collision_shape.position.x
	action_marker_flip_offset = action_marker.position.x

func handle_movement(speed : int) -> void:
	velocity.x = speed
	if speed > 0:
		collision_shape.position.x = col_shape_flip_offset
		action_marker.position.x = action_marker_flip_offset
		sprite.flip_h = false
	else:
		collision_shape.position.x = -col_shape_flip_offset
		action_marker.position.x = -action_marker_flip_offset
		sprite.flip_h = true


func animate_movement(player_rotation : int, delta) -> void:
	rotate_timer += delta

	if rotate_timer > rotate_time:
		rotate_timer = 0
		if sprite.rotation == 0:
			sprite.rotation = deg_to_rad(player_rotation)
		else:
			sprite.rotation = -sprite.rotation

func _physics_process(delta) -> void:
	if enabled:
		if Input.is_action_pressed("move_right"):
			handle_movement(player_speed)
			animate_movement(rotate_value, delta)
		elif Input.is_action_pressed("move_left"):
			handle_movement(-player_speed)
			animate_movement(-rotate_value, delta)
		else:
			velocity.x = 0
			sprite.rotation = deg_to_rad(0)
		move_and_collide(velocity * delta)
	
		if Input.is_action_just_pressed("interact"):
			if(interactable != null):
				disable_player()
				interactable.interact(self)


func set_interact(updated_interactable : Interactable) -> void: 
	action_marker.visible = true
	self.interactable = updated_interactable

func remove_interact(updated_interactable : Interactable) -> void: 
	if(updated_interactable == interactable):
		action_marker.visible = false
		self.interactable = null

func enable_player() -> void:
	self.enabled = true

func disable_player() -> void:
	self.enabled = false

