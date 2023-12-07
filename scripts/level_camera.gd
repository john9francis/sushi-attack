extends Camera2D

var speed = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	limit_left = -100
	limit_top = -100
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("MoveCameraDown"):
		position.y += speed * delta
	if Input.is_action_pressed("MoveCameraUp"):
		position.y -= speed * delta
	if Input.is_action_pressed("MoveCameraLeft"):
		position.x -= speed * delta
	if Input.is_action_pressed("MoveCameraRight"):
		position.x += speed * delta
	pass


