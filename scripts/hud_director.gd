extends CanvasLayer

@onready var pauseButton = $Pause
@onready var readyButton = $Ready
@onready var pauseMenu = $PauseMenu

var showReadyButton = true

func _ready():
	pauseMenu.hide()


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
	pauseMenu.hide()
	pauseButton.show()
	if showReadyButton:
		readyButton.show()
		
	get_tree().paused = false
	
func reset():
	pauseButton.show()
	readyButton.show()
	pauseMenu.hide()
