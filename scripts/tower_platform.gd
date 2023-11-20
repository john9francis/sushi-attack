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
const upgradeCost= 50

var nOfUpgrades
var towerMaxed = false

func _ready():
	$TowerGUI.hide()
	
	nOfUpgrades = 0
	


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
	if towerMaxed:
		return
	
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
		
	if money < upgradeCost:
		$TowerGUI/upgradeGUI/Upgrade.disabled = true
	else:
		$TowerGUI/upgradeGUI/Upgrade.disabled = false
		
		
		




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
	var originalCost = 0
	
	for child in get_children():
		if child.is_in_group("WTowers"):
			originalCost = WTowerCost
		if child.is_in_group("CSTowers"):
			originalCost = CSTowerCost
		if child.is_in_group("SSTowers"):
			originalCost = SSTowerCost
		if child.is_in_group("GTowers"):
			originalCost = GTowerCost
	
	var refund = originalCost - 20
			
	get_tree().call_group("LevelRunner", "add_money", refund)
	remove_tower()
	
	
func remove_tower():
	if tower != null:
		towerMaxed = false
		
		$TowerGUI.hide()
		tower.queue_free()
		$TowerGUI.go_to_platform_gui()
		
		# reset upgrades so the button isn't disabled
		nOfUpgrades = 0
		$TowerGUI/upgradeGUI/Upgrade.disabled = false
		




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
		get_tree().call_group("LevelRunner", "subtract_money", cost)
		
		# Make sure we have the right upgrade gui text
		$TowerGUI/upgradeGUI/Upgrade.text = "Upgrade"


func _on_upgrade_pressed():
	$TowerGUI.hide()
	
	for child in get_children():
		if child.is_in_group("Towers"):
			
			child.upgrade()
			nOfUpgrades += 1
			
			# minus the money
			get_tree().call_group("LevelRunner", "subtract_money", upgradeCost)
			
	# disable upgrades if it's at max level
	if nOfUpgrades >= 2:
		$TowerGUI/upgradeGUI/Upgrade.disabled = true
		$TowerGUI/upgradeGUI/Upgrade.text = "Maxed"
		towerMaxed = true
		
