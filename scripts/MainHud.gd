extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	hide_everything()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	$GameOverPopup.show()


func hide_everything():
	$PauseMenu.hide()
	$GameOverPopup.hide()
	$SuccessPopup.hide()
