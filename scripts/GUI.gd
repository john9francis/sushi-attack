extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$MainMenu.show()
	$LevelSelect.hide()
	$MainMenu/AnimatedSprite2D.play("right-down")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_game_pressed():
	$MainMenu.hide()
	$LevelSelect.show()
	pass # Replace with function body.
