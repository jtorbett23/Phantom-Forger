extends Node

func _ready():
	# AssetsHelper.setup_paintings()
	# Add Main Menu
	#real
	var real1 : Image = Image.load_from_file("res://assets/art/paintings/sea-star.png")
	var real2 : Image = Image.load_from_file("res://assets/art/paintings/bunny-slippers.png")
	var real3 : Image = Image.load_from_file("res://assets/art/paintings/axolotl.png")
	var real4 : Image = Image.load_from_file("res://assets/art/paintings/koala.png")
	var real5 : Image = Image.load_from_file("res://assets/art/paintings/pig.png")
	var real6 : Image = Image.load_from_file("res://assets/art/paintings/rabbit.png")
	var real7 : Image = Image.load_from_file("res://assets/art/paintings/whale-tail.png")
	var real8 : Image = Image.load_from_file("res://assets/art/paintings/tortoise.png")

	# #forges
	# var image2 : Image = Image.load_from_file("res://assets/art/paintings/forged/test.png")
	# var image3 : Image = Image.load_from_file("res://assets/art/paintings/forged/test-blank.png")
	# var image4 : Image = Image.load_from_file("res://assets/art/paintings/forged/test-3.png")
	# var image5 : Image = Image.load_from_file("res://assets/art/paintings/forged/test-4.png")

	# ImageData.new(image5, "1")
	ImageData.new(real1 , "1")
	ImageData.new(real2 , "2")
	ImageData.new(real3 , "3")
	ImageData.new(real4 , "4")
	ImageData.new(real5 , "5")
	ImageData.new(real6 , "6")
	ImageData.new(real7 , "7")
	ImageData.new(real8 , "8")



	


	# print("Compare real with attempted forge")
	# print("--------------")
	# AssetsHelper.calculate_image_similarity(image1, image2)

	# print("Compare real with bad forge")
	# print("--------------")
	# AssetsHelper.calculate_image_similarity(image1, image4)


	# print("Compare real with blank canvas")
	# print("--------------")
	# AssetsHelper.calculate_image_similarity(image1, image3)

	# print("Compare real with black canvas")
	# print("--------------")
	# AssetsHelper.calculate_image_similarity(image1, image5)

	var main_menu = MainMenu.new()
	Camera.add_ui(main_menu)
