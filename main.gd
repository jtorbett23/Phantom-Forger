extends Node

func _ready():
	# AssetsHelper.setup_paintings()
	# Add Main Menu
	#real
	var image1 : Image = Image.load_from_file("res://assets/art/paintings/sea-star.png")
	#forges
	var image2 : Image = Image.load_from_file("res://assets/art/paintings/forged/test.png")
	var image3 : Image = Image.load_from_file("res://assets/art/paintings/forged/test-blank.png")
	print("Compare real with attempted forge")
	print("--------------")
	AssetsHelper.calculate_image_similarity(image1, image2)

	print("Compare real with blank canvas")
	print("--------------")
	AssetsHelper.calculate_image_similarity(image1, image3)

	var main_menu = MainMenu.new()
	Camera.add_ui(main_menu)
