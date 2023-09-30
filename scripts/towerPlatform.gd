extends Area2D

var mouse_in_tower = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$TowerGUI.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("Click"):
		if mouse_in_tower:
			$TowerGUI.show()
		else:
			$TowerGUI.hide()
	pass


func _on_mouse_entered():
	mouse_in_tower = true
	pass # Replace with function body.


func _on_mouse_exited():
	mouse_in_tower = false
	pass # Replace with function body.
