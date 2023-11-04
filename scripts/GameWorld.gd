extends Node2D

@export var levelScene : PackedScene
var level

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func go_to_level(levelName):
	level = levelScene.instantiate()
	level.setup_level(levelName)
	#level.set_up_level(levelName)
	add_child(level)
	
	# make sure it's unpaused
	get_tree().paused = false
	pass

func delete_level():
	level.queue_free()

