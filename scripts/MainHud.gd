extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Resume.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pause_pressed():
	$Pause.hide()
	$Resume.show()
	pass # Replace with function body.




func _on_resume_pressed():
	$Resume.hide()
	$Pause.show()
	pass # Replace with function body.
