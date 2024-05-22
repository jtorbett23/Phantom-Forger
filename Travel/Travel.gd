extends Node2D

@onready var player : CharacterBody2D = $Player
var music_path : String = "res://assets/audio/music/nighttime.mp3"
@onready var office : TileMap = $Office
@onready var halls12 : TileMap = $"Halls1-2"
@onready var halls4 : TileMap = $Halls4
var results_scene : String = "res://Menus/results.tscn"

var ui : Array = []
var header : HeaderTurbo

var camera : Camera2DTurbo = Camera2DTurbo.new()

func _ready() -> void:
	PaintingState.count = 0
	AudioManager.play_music(music_path)
	add_child(camera)
	camera.set_follow(player)
	header = HeaderTurbo.new("res://assets/Themes/ui-forger-3.png")
	UiManager.add(header)
	header.set_content("TravelHeader",
	[ 
		{"name": "Suspicion", "type": Label},
		{"name": "Money", "type": Label},
		{"name":"Settings", "callback": Callable(self, "settings")}]
	)

	ui.append(header)

	set_office_limits()
	update_header_money(GameState.money)
	update_header_sus(GameState.suspicion)

func settings() -> void:
	player.disable_player()
	UiManager.add((SettingsMenu.new(Callable(self, "post_fade_out"))))

func post_fade_out() -> void:
	player.sprite.modulate = GameState.herb_colour
	player.enable_player()

func set_office_limits() -> void:
	var cellsize = office.tile_set.tile_size
	# Camera Limits - Office
	var office_limits = office.get_used_rect()
	camera.set_limits(office_limits.position.x * cellsize.x, office_limits.end.x * cellsize.x * office.scale.x)

func set_halls_limits() -> void:
	var cellsize = halls12.tile_set.tile_size
	# Camera Limits - Halls
	var halls_end_limits = halls4.get_used_rect()
	var halls_start_x = halls12.position.x
	var halls_end_x =  halls4.position.x + halls_end_limits.end.x * cellsize.x * halls4.scale.x
	camera.set_limits(halls_start_x, halls_end_x)

func update_header_money(value: int):
	header.update_label("Money", ": £" + str(value))

func update_header_sus(value: float):
	var rounded_value : String = str(round(value))
	header.update_label("Suspicion", ": " + rounded_value + "%")

func trigger_alarm():
	UiManager.add(AlarmPopup.new("Alarm triggered! Escape while you can!", PopupTurbo.STATIC, Callable(self, "caught")))

func caught():
	player.disable_player()
	SceneManager.change_scene(self, results_scene, Callable(), false, UiManager.layers[0])
