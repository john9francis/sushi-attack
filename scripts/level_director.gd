extends Node2D

@onready var levelRunner = $LevelRunner
@onready var levelSetup = $LevelSetup

signal in_level

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func go_to_level(levelName):
	$LevelRunner.set_premade_level(levelName)
	emit_signal("in_level")


func _on_l_1_pressed():
	go_to_level("Level1")
	pass # Replace with function body.
