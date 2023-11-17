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
	


func _on_reset_pressed():
	get_tree().call_group("LevelRunner", "reset")
	showReadyButton = true
	
	_on_resume_pressed()
	pass # Replace with function body.
