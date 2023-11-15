extends CanvasLayer

@onready var pauseButton = $Pause
@onready var readyButton = $Ready

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_level_director_hide_ready():
	readyButton.hide()
	pass # Replace with function body.
