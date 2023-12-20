extends Button

var buttonName


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_button_name(n):
	buttonName = n
	text = buttonName



func _on_button_up():
	get_tree().call_group("LevelDirector", "go_to_level", buttonName)
	if buttonName == "Level 1":
		# show the tutorial
		get_tree().call_group("MainHud", "_on_tutorial_pressed")
