extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$HUD.hide()
	# For testing purposes: let's skip the main menu
	#_on_l_1_pressed()
	
	# disable button till it's ready
	#$GUI/LevelSelect/L2.disabled = true
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_l_1_pressed():
	go_to_level("L1")
	
	
	
func go_to_level(levelName):
	$GUI/LevelSelect.hide()
	$GameWorld.go_to_level(levelName)
	$HUD.show()
	pass


func _on_to_main_menu_pressed():
	$GameWorld.delete_level()
	$GUI/MainMenu.show()
	$HUD.hide_everything()
	$HUD.hide()
	
	# Make sure it's unpaused
	_on_resume_pressed()
	
	pass # Replace with function body.


func _on_l_2_pressed():
	go_to_level("L2")
	pass # Replace with function body.


func _on_pause_pressed():
	$HUD/Pause.hide()
	$HUD/PauseMenu.show()
	get_tree().paused = true
	pass # Replace with function body.



func _on_resume_pressed():
	$HUD/PauseMenu.hide()
	$HUD/Pause.show()
	get_tree().paused = false
	pass # Replace with function body.


func _on_reset_pressed():
	$HUD.hide_everything()
	
	# Make sure we're unpaused
	_on_resume_pressed()
	
	get_tree().call_group("CurrentLevel", "stop_game")
	get_tree().call_group("CurrentLevel", "reset")
	pass # Replace with function body.


func _on_play_again_pressed():
	_on_reset_pressed()
	pass # Replace with function body.


func _on_test_level_pressed():
	go_to_level("TestLevel")
	pass # Replace with function body.
