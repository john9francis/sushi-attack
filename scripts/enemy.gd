extends Area2D

const speed = 5
var currentSpeed = 5
@export var myPathFollowScene: PackedScene
var myPathFollow


func _ready():
	add_to_group("Enemies")
	


func _process(_delta):
	pass
	

func set_speed(s):
	currentSpeed = s
	myPathFollow.set_speed(currentSpeed)


func get_path_follow():
	myPathFollow = myPathFollowScene.instantiate()
	myPathFollow.set_speed(currentSpeed)
	return myPathFollow


func multiply_speed(s):
	currentSpeed *= s
	myPathFollow.set_speed(currentSpeed)
	
