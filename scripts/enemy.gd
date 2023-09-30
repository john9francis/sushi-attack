extends Area2D

@export var speed = 10
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
	myPathFollow.set_speed(s)
	print("Speed reduced")

func get_path_follow():
	myPathFollow = myPathFollowScene.instantiate()
	myPathFollow.set_speed(10)
	return myPathFollow
