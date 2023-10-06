extends CanvasLayer

@export var LevelScene : PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	var level = LevelScene.instantiate()
	
	$Lives.text = str(level.lives)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
