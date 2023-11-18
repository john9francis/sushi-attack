extends CanvasLayer

@onready var mainMenu = $MainMenu
@onready var levelSelect = $LevelSelect
@onready var levelButtonContainer = $LevelSelect/LevelButtonContainer

signal levelButtonPressed(levelName)

func _ready():
	mainMenu.show()
	levelSelect.hide()


func _process(delta):
	if Input.is_action_just_released("Click"):
		print("click")
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
		#levelButton.connect("pressed", _on_level_button_pressed)
		#levelButton.pressed.connect(self._on_level_button_pressed)
		
		levelButtonContainer.add_child(levelButton)
		
		
		
func _on_level_button_pressed():
	
	var levelName = "test"
	
	# This don't work:
	#print("Button pressed:", get_node("Button").text)
	
	#print(levelName)

