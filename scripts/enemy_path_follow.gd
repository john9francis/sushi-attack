extends PathFollow2D

var speed = 1

func _ready():
	progress = 0
	
	# set random offset from the path
	v_offset = randi() % 100 - 50


func _process(delta):
	progress += speed
	
	
func set_speed(s):
	speed = s
