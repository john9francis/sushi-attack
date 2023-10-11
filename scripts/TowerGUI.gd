extends Control


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
