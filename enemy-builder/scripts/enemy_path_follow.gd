extends PathFollow2D

var speed = 1
var reward = 10
var in_destination = false

func _ready():
	progress = 0
	
	rotates = false
	rotation = 0
	
	# set random offset from the path
	v_offset = randi() % 100 - 50


func _process(delta):
	if speed != null:
		progress += speed
	else:
		print("Enemy did not set speed right")
	
	
func set_speed(s):
	speed = s
	
func get_speed():
	return speed
	
func set_reward(r):
	reward = r
	
func get_reward():
	return reward


func set_in_destionation():
	in_destination = true
