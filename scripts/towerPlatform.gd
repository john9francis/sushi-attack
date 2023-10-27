extends Area2D

var mouse_in_tower = false

@export var CSTowerScene : PackedScene
@export var SSTowerScene : PackedScene
@export var GTowerScene : PackedScene
@export var WTowerScene : PackedScene

var tower
const WTowerCost = 60
const GTowerCost = 50
const SSTowerCost= 30
const CSTowerCost= 70


func _ready():
	$TowerGUI.hide()
	
	# FOR NOW... 
	#$TowerGUI/upgradeGUI/Upgrade.disabled = true


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
	if money < SSTowerCost:
		$TowerGUI/platformGUI/SSButton.disabled = true
	else:
		$TowerGUI/platformGUI/SSButton.disabled = false
		
	if money < WTowerCost:
		$TowerGUI/platformGUI/WButton.disabled = true
	else:
		$TowerGUI/platformGUI/WButton.disabled = false
		
	if money < GTowerCost:
		$TowerGUI/platformGUI/GButton.disabled = true
	else:
		$TowerGUI/platformGUI/GButton.disabled = false
		
	if money < CSTowerCost:
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
	remove_tower()
	
	
func remove_tower():
	if tower != null:
		$TowerGUI.hide()
		tower.queue_free()
		$TowerGUI.go_to_platform_gui()




func _on_child_entered_tree(node):
	var cost = 0
	if node.is_in_group("WTowers"):
		cost = WTowerCost
	if node.is_in_group("GTowers"):
		cost = GTowerCost
	if node.is_in_group("CSTowers"):
		cost = CSTowerCost
	if node.is_in_group("SSTowers"):
		cost = SSTowerCost
		
	if node.is_in_group("Towers"):
		get_tree().call_group("CurrentLevel", "subtract_money", cost)	


func _on_upgrade_pressed():
	$TowerGUI/upgradeGUI.hide()
	get_tree().call_group("Upgrades", "_upgrade")
	pass # Replace with function body.
