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
		print("Hovering")
	else:
		pass
		
	if ssButton.is_hovered():
		pass
	if gButton.is_hovered():
		pass
	if wButton.is_hovered():
		pass
	if sellButton.is_hovered():
		pass
	if upgradeButton.is_hovered():
		pass
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
	



func _on_cs_button_mouse_entered():
	csButton.text = csButtonText + '\n' + "$ " + str(csValue)
	pass # Replace with function body.

func _on_cs_button_mouse_exited():
	csButton.text = csButtonText
	pass # Replace with function body.
	
	
	
func _on_ss_button_mouse_entered():
	ssButton.text = ssButtonText + '\n' + "$ " + str(ssValue)
	pass # Replace with function body.

func _on_ss_button_mouse_exited():
	ssButton.text = ssButtonText
	pass # Replace with function body.
	
	
	
func _on_g_button_mouse_entered():
	gButton.text = gButtonText + '\n' + "$ " + str(gValue)
	pass # Replace with function body.

func _on_g_button_mouse_exited():
	gButton.text = gButtonText
	pass # Replace with function body.
	
	
	
func _on_w_button_mouse_entered():
	wButton.text = wButtonText + '\n' + "$ " + str(wValue)
	pass # Replace with function body.

func _on_w_button_mouse_exited():
	wButton.text = wButtonText
	pass # Replace with function body.
	
	


func _on_upgrade_mouse_entered():
	upgradeButton.text = upgradeButtonText + '\n' + "$ " + str(upgradeValue)
	pass # Replace with function body.


func _on_upgrade_mouse_exited():
	upgradeButton.text = upgradeButtonText
	pass # Replace with function body.




func _on_sell_mouse_entered():
	sellButton.text = sellButtonText + '\n' + "+ $ " + str(sellValue)
	pass # Replace with function body.


func _on_sell_mouse_exited():
	sellButton.text = sellButtonText
	pass # Replace with function body.
