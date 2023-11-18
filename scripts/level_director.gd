extends Node2D

@onready var levelRunner = $LevelRunner
@onready var levelSetup = $LevelRunner/LevelSetup

signal hide_ready

signal in_level

# Called when the node enters the scene tree for the first time.
func _ready():
	levelRunner.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# This is what all the buttons call: 
func go_to_level(levelName):
	levelRunner.set_premade_level(levelName)
	emit_signal("in_level")
	levelRunner.show()



func _on_ready_pressed():
	print("Ready pressed")
	levelRunner.start_game()
	emit_signal("hide_ready")
	pass # Replace with function body.



func clear_level():
	levelRunner.clear_level()
	levelRunner.hide()

