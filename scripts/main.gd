extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$GUI.show()

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_l_1_pressed():
	$GUI.hide()
	$GUI/LevelSelect.hide()
	$GameWorld.go_to_level()
	pass # Replace with function body.
