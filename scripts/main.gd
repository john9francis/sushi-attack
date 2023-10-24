extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$HUD.hide()
	# For testing purposes: let's skip the main menu
	_on_l_1_pressed()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_l_1_pressed():
	go_to_level("L1")
	pass # Replace with function body.
	
func go_to_level(levelName):
	$GUI/LevelSelect.hide()
	$GameWorld.go_to_level(levelName)
	$HUD.show()
	pass


func _on_to_main_menu_pressed():
	$GameWorld.delete_level()
	$GUI/MainMenu.show()
	$HUD.hide()
	
	pass # Replace with function body.


func _on_l_2_pressed():
	go_to_level("L2")
	pass # Replace with function body.
