extends PathFollow2D

var speed = 1
var value = 10
var in_destination = false

func _ready():
	progress = 0
	
	# set random offset from the path
	v_offset = randi() % 100 - 50


func _process(delta):
	progress += speed
	
	
func set_speed(s):
	speed = s
	
func get_speed():
	return speed
	
func set_value(v):
	value = v


func set_in_destionation():
	in_destination = true
