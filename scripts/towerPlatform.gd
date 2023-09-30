extends Area2D

var mouse_in_tower = false

@export var CSTower : PackedScene
@export var SSTower : PackedScene
@export var GTower : PackedScene
@export var WTower : PackedScene

func _ready():
	$TowerGUI.hide()


func _process(delta):
	if Input.is_action_pressed("Click"):
		if mouse_in_tower:
			if $TowerGUI:
				$TowerGUI.show()
		else:
			if $TowerGUI:
				$TowerGUI.hide()


func _on_mouse_entered():
	mouse_in_tower = true


func _on_mouse_exited():
	mouse_in_tower = false


func _on_ss_button_pressed():
	# Get rid of the tower gui
	$TowerGUI.queue_free()
	var ss_tower = SSTower.instantiate()
	add_child(ss_tower)
	
