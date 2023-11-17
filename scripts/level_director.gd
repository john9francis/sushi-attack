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

func go_to_level(levelName):
	levelRunner.set_premade_level(levelName)
	emit_signal("in_level")
	levelRunner.show()



func _on_l_1_button_up():
	go_to_level("Level1")
	pass # Replace with function body.


func _on_ready_pressed():
	print("Ready pressed")
	levelRunner.start_game()
	emit_signal("hide_ready")
	pass # Replace with function body.


func _on_l_2_pressed():
	go_to_level("Level2")
	pass # Replace with function body.


func clear_level():
	levelRunner.clear_level()
	levelRunner.hide()
