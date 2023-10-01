extends Area2D

var mouse_in_tower = false

@export var CSTowerScene : PackedScene
@export var SSTowerScene : PackedScene
@export var GTowerScene : PackedScene
@export var WTowerScene : PackedScene

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
	var ssTower = SSTowerScene.instantiate()
	add_child(ssTower)



func _on_cs_button_pressed():
	$TowerGUI.queue_free()
	var csTower = CSTowerScene.instantiate()
	add_child(csTower)




func _on_g_button_pressed():
	$TowerGUI.queue_free()
	var gTower = GTowerScene.instantiate()
	add_child(gTower)


func _on_w_button_pressed():
	$TowerGUI.queue_free()
	var wTower = WTowerScene.instantiate()
	add_child(wTower)
