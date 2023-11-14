extends CanvasLayer

@onready var mainMenu = $MainMenu
@onready var levelSelect = $LevelSelect

func _ready():
	mainMenu.show()
	levelSelect.hide()


func _process(delta):
	pass


func _on_level_select_button_pressed():
	levelSelect.show()
	mainMenu.hide()
	pass # Replace with function body.


func _on_to_main_menu_pressed():
	mainMenu.show()
	levelSelect.hide()
	pass # Replace with function body.


