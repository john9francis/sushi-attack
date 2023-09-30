extends Area2D

var mouse_in_tower = false

@export var CSTower : PackedScene
@export var SSTower : PackedScene
@export var GTower : PackedScene
@export var WTower : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$TowerGUI.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("Click"):
		if mouse_in_tower:
			if $TowerGUI:
				$TowerGUI.show()
		else:
			if $TowerGUI:
				$TowerGUI.hide()
	pass


func _on_mouse_entered():
	mouse_in_tower = true
	pass # Replace with function body.


func _on_mouse_exited():
	mouse_in_tower = false
	pass # Replace with function body.


func _on_ss_button_pressed():
	# Get rid of the tower gui
	$TowerGUI.queue_free()
	
	# Add a tower as a child
	var ss_tower = SSTower.instantiate()
	add_child(ss_tower)
	
