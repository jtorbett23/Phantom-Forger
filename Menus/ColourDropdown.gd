extends HOptionButtonTurbo

class_name ColourDropDown

var herb_path : String = "res://assets/art/herb.png"
var sprite : Sprite2D 
var sprite_size : Vector2 = Vector2(100,100)


func _init() -> void:
	super()
	sprite = Sprite2D.new()
	sprite.texture = load(herb_path)
	sprite.scale = sprite_size / sprite.texture.get_size()
	add_child(sprite)
	dropdown.connect("item_selected", update_colour)

func set_content(dropdown_info : Dictionary) -> void:
	super(dropdown_info)
	set_sprite_colour(dropdown_info["value"])

func set_sprite_colour(colour_name : String) -> void:
	sprite.modulate = GameState.name_to_colour[colour_name]

func update_colour(index) -> void:
	var colour_name : String = dropdown.get_item_text(index)
	GameState.game_tint_name = colour_name
	set_sprite_colour(colour_name)




