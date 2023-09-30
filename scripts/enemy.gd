extends Area2D

const speed = 10
var currentSpeed = 10
@export var myPathFollowScene: PackedScene

var myPathFollow

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Enemies")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	

func set_speed(s):
	currentSpeed = s
	myPathFollow.set_speed(currentSpeed)
	print("Speed reduced")

func get_path_follow():
	myPathFollow = myPathFollowScene.instantiate()
	myPathFollow.set_speed(currentSpeed)
	return myPathFollow

func reduce_speed(s):
	# reduces speed by subtracting 's'
	currentSpeed -= s
	myPathFollow.set_speed(currentSpeed)
	pass

	
func add_speed(s):
	currentSpeed += s
	myPathFollow.set_speed(currentSpeed)
	
	
func multiply_speed(s):
	currentSpeed *= s
	myPathFollow.set_speed(currentSpeed)
	

func divide_speed(s):
	currentSpeed /= s
	myPathFollow.set_speed(currentSpeed)
	
		
func resume_speed():
	currentSpeed = speed
	myPathFollow.set_speed(currentSpeed)
	pass
