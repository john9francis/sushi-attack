extends PathFollow2D

var speed = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	progress = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	progress += speed
	pass
	


func _on_area_2d_area_entered(area):
	# if this is the destination, delete this 
	#if (area.get_instance_id())
	print(area.get_instance_id())
	queue_free()
