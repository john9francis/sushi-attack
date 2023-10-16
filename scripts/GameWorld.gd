extends Node2D

@export var levelScene : PackedScene
var level

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func go_to_level():
	level = levelScene.instantiate()
	add_child(level)
	pass

func delete_level():
	level.queue_free()


func _on_pause_pressed():
	level.pause()
	pass # Replace with function body.
