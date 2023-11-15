extends Node

@onready var gui = $Gui
@onready var hud = $Hud
@onready var levelDirector = $LevelDirector


# Called when the node enters the scene tree for the first time.
func _ready():
	$Gui.show()
	$Hud.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func _on_level_director_in_level():
	$Hud.show()
	$Gui/LevelSelect.hide()
	pass # Replace with function body.



func _on_to_main_menu_pressed():
	hud.reset()
	hud.hide()
	
	gui.show_main_menu()
	levelDirector.clear_level()
	pass # Replace with function body.
