extends Area2D

@export var speed = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Enemies")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	

func reduce_speed():
	speed = 5
	print("Speed reduced")
