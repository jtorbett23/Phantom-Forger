extends Node

func _ready():
	# AssetsHelper.setup_paintings()
	# Add Main Menu
	#real
	# var real2 : Image = Image.load_from_file("res://assets/art/paintings/bunny-slippers.png")
	# var real4 : Image = Image.load_from_file("res://assets/art/paintings/koala.png")
	# var real5 : Image = Image.load_from_file("res://assets/art/paintings/pig.png")
	# var real6 : Image = Image.load_from_file("res://assets/art/paintings/rabbit.png")
	# var real7 : Image = Image.load_from_file("res://assets/art/paintings/whale-tail.png")
	# var real8 : Image = Image.load_from_file("res://assets/art/paintings/tortoise.png")

	# #sea star
	# var real1 : Image = Image.load_from_file("res://assets/art/paintings/sea-star.png")
	# # #forges
	# var fake1 : Image = Image.load_from_file("res://assets/art/paintings/forged/test.png")
	# var fake2 : Image = Image.load_from_file("res://assets/art/paintings/forged/test-blank.png")
	# var fake3 : Image = Image.load_from_file("res://assets/art/paintings/forged/test-3.png")
	# var fake4 : Image = Image.load_from_file("res://assets/art/paintings/forged/test-4.png")

	#axolotol

	var real1 : Image = Image.load_from_file("res://assets/art/paintings/axolotl.png")

	var fake1 : Image = Image.load_from_file("res://assets/art/paintings/forged/axo-1.png")

	# ImageData.new(image5, "1")
	var data1 = ImageData.new(real1)
	# data1.visualise_shape("1")
	var data2 = ImageData.new(fake1)
	# data2.visualise_shape("2")
	# var data3 = ImageData.new(fake2)
	# # data3.visualise_shape("3")
	# var data4 = ImageData.new(fake3)

	# var data5 = ImageData.new(fake4)

	print("---------")
	data1.compare(data2)
	print("---------")
	# data1.compare(data3)
	# print("---------")
	# data1.compare(data4)
	# print("---------")
	# data1.compare(data5)
	# print("---------")




	



	


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
