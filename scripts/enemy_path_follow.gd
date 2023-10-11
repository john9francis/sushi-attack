extends PathFollow2D

var speed = 1
var in_destination = false

func _ready():
	progress = 0
	
	# set random offset from the path
	v_offset = randi() % 100 - 50


func _process(delta):
	progress += speed
	
	
func set_speed(s):
	speed = s


func set_in_destionation():
	in_destination = true
