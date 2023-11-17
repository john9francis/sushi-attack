extends CanvasLayer

@onready var mainMenu = $MainMenu
@onready var levelSelect = $LevelSelect
@onready var levelButtonContainer = $LevelSelect/LevelButtonContainer

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


func show_main_menu():
	mainMenu.show()
	levelSelect.hide()
	pass
	

func populate_level_buttons(levelList):
	for levelName in levelList:
		var levelButton = Button.new()
		levelButton.text = levelName
		
		# link up the button to go to that scene
		levelButton.connect("pressed", self._on_level_button_pressed)
		
		levelButtonContainer.add_child(levelButton)
		
		
		
func _on_level_button_pressed():
	var levelName = "test"
	print(levelName)
