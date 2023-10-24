extends RigidBody2D

var destination

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position == destination:
		print("In destination")
	pass


func set_destination(vector):
	# Sets the destination, prints when the bullet hits there
	destination = vector
	pass
