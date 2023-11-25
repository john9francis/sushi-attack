extends Control

var csValue = 1
var ssValue = 2
var gValue = 3
var wValue = 4

@onready var csButton = $platformGUI/CSButton
const csButtonText = "Chop Sticks"

@onready var ssButton = $platformGUI/SSButton
const ssButtonText = "Soy Sauce"

@onready var wButton = $platformGUI/WButton
const wButtonText = "Wasabi"

@onready var gButton = $platformGUI/GButton
const gButtonText = "Ginger"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	$upgradeGUI.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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


func set_value(towerName="cs, ss, g, or w.", value=0):
	
	if towerName == "cs":
		csValue = value
		
	elif towerName == "ss":
		ssValue = value
		
	elif towerName == "g":
		gValue = value
		
	elif towerName == "w":
		wValue = value
		
	else:
		print("Set_value error in towerGUI")
	



func _on_cs_button_mouse_entered():
	csButton.text = csButtonText + '\n' + str(csValue)
	pass # Replace with function body.

func _on_cs_button_mouse_exited():
	csButton.text = csButtonText
	pass # Replace with function body.
	
	
	
func _on_ss_button_mouse_entered():
	ssButton.text = ssButtonText + '\n' + str(ssValue)
	pass # Replace with function body.

func _on_ss_button_mouse_exited():
	ssButton.text = ssButtonText
	pass # Replace with function body.
	
	
	
func _on_g_button_mouse_entered():
	gButton.text = gButtonText + '\n' + str(gValue)
	pass # Replace with function body.

func _on_g_button_mouse_exited():
	gButton.text = gButtonText
	pass # Replace with function body.
	
	
	
func _on_w_button_mouse_entered():
	wButton.text = wButtonText + '\n' + str(wValue)
	pass # Replace with function body.

func _on_w_button_mouse_exited():
	wButton.text = wButtonText
	pass # Replace with function body.
	
