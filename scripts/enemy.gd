extends PathFollow2D


# Called when the node enters the scene tree for the first time.
func _ready():
	progress = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	progress += 1
	pass
