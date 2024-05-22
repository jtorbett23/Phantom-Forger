extends MenuTurbo

var music_path : String = "res://assets/audio/music/daytime.mp3"

@onready var money : Label = $OutcomeContainer/Money
@onready var sus : Label = $OutcomeContainer/Suspicion 
@onready var outcome : Label = $OutcomeContainer/Outcome

func _init():
	title_percentage_from_top = GameState.ui_title_from_top
	button_min_size = Vector2(140,30)
	super._init("res://assets/Themes/ui-forger-2.png")


func _ready() -> void:
	# Camera.set_static()
	AudioManager.play_music(music_path)
	var menu_content : Array[Dictionary] = [
		{"name":"Exit", "callback" : Callable(self, "exit")}
	]

	# if GameState.suspicion < 100:
	# 	menu_content.append({"name":"Continue"})

	self.set_content("Results", 
	menu_content)

	money.custom_minimum_size = label_min_size
	money.text = "Money: £" + str(GameState.money) + "/" + str(GameState.money_goal)
	sus.custom_minimum_size = label_min_size
	sus.text = "Suspicion: " + str(round(GameState.suspicion)) + "%"
	outcome.custom_minimum_size = Vector2(250, 30)
	var escaped_text : String = "escaped without getting caught."
	var debt_text : String = "managed to pay their debt."

	if GameState.money <= GameState.money_goal:
		debt_text = "did not get enough money to pay their debt."

	if GameState.suspicion == 100:
		escaped_text = "escaped but is on the run from police."
		if GameState.money <= GameState.money_goal:
			escaped_text = "escaped but is on the run from police and debt collectors."

	
	if GameState.suspicion < 100 and GameState.money <= GameState.money_goal:
			escaped_text = "escaped but is on the run from debt collectors."

	if GameState.escaped == false:
		escaped_text = "did not escape and was sent to jail."
		debt_text = "were unable to sell the paintings to pay their debt."
	
	var outcome_text : String = "Herb " + escaped_text+ "\n" + " From the heist they " + str(debt_text)

	outcome.text = outcome_text



func exit():
	SceneManager.change_scene(self, MainMenu, Callable(), false, UiManager.layers[0])



