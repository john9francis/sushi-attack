extends Control

var csValue = 1
var ssValue = 2
var gValue = 3
var wValue = 4

var upgradeValue = 5
var sellValue = 6

@onready var csButton = $platformGUI/CSButton
const csButtonText = "Chop Sticks"

@onready var ssButton = $platformGUI/SSButton
const ssButtonText = "Soy Sauce"

@onready var wButton = $platformGUI/WButton
const wButtonText = "Wasabi"

@onready var gButton = $platformGUI/GButton
const gButtonText = "Ginger"

@onready var upgradeButton = $upgradeGUI/Upgrade
const upgradeButtonText = "Upgrade"

@onready var sellButton = $upgradeGUI/Sell
const sellButtonText = "Sell"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	$upgradeGUI.hide()
	
	csButton.text = csButtonText
	ssButton.text = ssButtonText
	gButton.text = gButtonText
	wButton.text = wButtonText
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if csButton.is_hovered():
		csButton.text = csButtonText + '\n'+ '$ ' + str(csValue)
	else:
		csButton.text = csButtonText


	if ssButton.is_hovered():
		ssButton.text = ssButtonText + '\n'+ '$ ' + str(ssValue)
	else:
		ssButton.text = ssButtonText


	if gButton.is_hovered():
		gButton.text = gButtonText + '\n'+ '$ ' + str(gValue)
	else:
		gButton.text = gButtonText


	if wButton.is_hovered():
		wButton.text = wButtonText + '\n'+ '$ ' + str(wValue)
	else:
		wButton.text = wButtonText


	if upgradeButton.is_hovered():
		upgradeButton.text = upgradeButtonText + '\n'+ '$ ' + str(upgradeValue)
	else:
		upgradeButton.text = upgradeButtonText


	if sellButton.is_hovered():
		sellButton.text = sellButtonText + '\n'+ '$ ' + str(sellValue)
	else:
		sellButton.text = sellButtonText
	pass



func go_to_upgrade_gui():
	$platformGUI.hide()
	$upgradeGUI.show()


func go_to_platform_gui():
	$upgradeGUI.hide()
	$platformGUI.show()


func _on_gui_input(event):
	accept_event()
	pass # Replace with function body.


func set_value(towerName, value):
	
	if towerName == "cs":
		csValue = value
		
	elif towerName == "ss":
		ssValue = value
		
	elif towerName == "g":
		gValue = value
		
	elif towerName == "w":
		wValue = value
		
	elif towerName == "upgrade":
		upgradeValue = value
		
	elif towerName == "sell":
		sellValue = value
		
	else:
		print("Set_value error in towerGUI")
	
