extends CanvasLayer

@onready var mainMenu = $MainMenu
@onready var levelSelect = $LevelSelect
@onready var levelButtonContainer = $LevelSelect/LevelButtonContainer

func _ready():
	mainMenu.show()
	levelSelect.hide()
	for i in range(10):
		var b = Button.new()
		b.text = str(i)
		levelButtonContainer.add_child(b)


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


func show_main_menu():
	mainMenu.show()
	levelSelect.hide()
	pass
