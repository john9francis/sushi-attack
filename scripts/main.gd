extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$Gui.show()
	$Hud.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_level_director_in_level():
	$Gui.hide()
	$Hud.show()
	pass # Replace with function body.
