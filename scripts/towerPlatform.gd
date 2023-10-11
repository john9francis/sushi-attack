extends Area2D

var mouse_in_tower = false

@export var CSTowerScene : PackedScene
@export var SSTowerScene : PackedScene
@export var GTowerScene : PackedScene
@export var WTowerScene : PackedScene

var tower

func _ready():
	$TowerGUI.hide()
	
	# FOR NOW... 
	$TowerGUI/upgradeGUI/Upgrade.disabled = true


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
	
	
func update_buttons(money):
	if money < 30:
		$TowerGUI/platformGUI/SSButton.disabled = true
	else:
		$TowerGUI/platformGUI/SSButton.disabled = false
		
	if money < 50:
		$TowerGUI/platformGUI/WButton.disabled = true
		$TowerGUI/platformGUI/GButton.disabled = true
	else:
		$TowerGUI/platformGUI/WButton.disabled = false
		$TowerGUI/platformGUI/GButton.disabled = false
		
	if money < 70:
		$TowerGUI/platformGUI/CSButton.disabled = true
	else:
		$TowerGUI/platformGUI/CSButton.disabled = false
		
		
		




func _on_ss_button_pressed():
	# Get rid of the tower gui
	$TowerGUI.hide()
	$TowerGUI.go_to_upgrade_gui()
	tower = SSTowerScene.instantiate()
	add_child(tower)


func _on_cs_button_pressed():
	$TowerGUI.hide()
	$TowerGUI.go_to_upgrade_gui()
	tower = CSTowerScene.instantiate()
	add_child(tower)


func _on_g_button_pressed():
	$TowerGUI.hide()
	$TowerGUI.go_to_upgrade_gui()
	tower = GTowerScene.instantiate()
	add_child(tower)


func _on_w_button_pressed():
	$TowerGUI.hide()
	$TowerGUI.go_to_upgrade_gui()
	tower = WTowerScene.instantiate()
	add_child(tower)
	



func _on_sell_pressed():
	$TowerGUI.hide()
	# sell the tower
	tower.queue_free()
	$TowerGUI.go_to_platform_gui()
	




func _on_child_entered_tree(node):
	if node.is_in_group("Towers"):
		get_tree().call_group("CurrentLevel", "subtract_money", 10)
