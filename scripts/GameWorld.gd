extends Node2D

@export var levelRunnerScene : PackedScene
var levelRunner

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func go_to_level(levelName):
	levelRunner = levelRunnerScene.instantiate()
	levelRunner.setup_level(levelName)
	#level.set_up_level(levelName)
	add_child(levelRunner)
	
	# make sure it's unpaused
	get_tree().paused = false
	pass

func delete_level():
	levelRunner.queue_free()

