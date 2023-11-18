extends CanvasLayer

@onready var pauseButton = $Pause
@onready var readyButton = $Ready
@onready var pauseMenu = $PauseMenu
@onready var gameOverMenu = $GameOverMenu
@onready var successMenu = $SuccessMenu

var menus = []

var showReadyButton = true

func _ready():
	menus = [pauseMenu, gameOverMenu, successMenu]	
	for m in menus:
		m.hide()


func _process(delta):
	pass


func _on_level_director_hide_ready():
	readyButton.hide()
	showReadyButton = false


func _on_pause_pressed():
	pauseButton.hide()
	pauseMenu.show()
	readyButton.hide()
	
	get_tree().paused = true


func _on_resume_pressed():
	for menu in menus:
		menu.hide()
	pauseButton.show()
	if showReadyButton:
		readyButton.show()
		
	get_tree().paused = false
	

func reset():
	pauseButton.show()
	readyButton.show()
	for menu in menus:
		menu.hide()
	


func _on_reset_pressed():
	get_tree().call_group("LevelRunner", "reset")
	showReadyButton = true
	
	_on_resume_pressed()
	pass # Replace with function body.


func _on_level_runner_game_over_signal():
	pauseButton.hide()
	gameOverMenu.show()
	readyButton.hide()
	
	get_tree().paused = true
	pass # Replace with function body.
	
	
func show_success_menu():
	pauseButton.hide()
	successMenu.show()
	readyButton.hide()
	
	get_tree().paused = true
