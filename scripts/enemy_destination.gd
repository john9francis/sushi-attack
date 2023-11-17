extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#print("enemy destination in tree")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_area_entered(area):
	if area.is_in_group("Enemies"):
		area.set_reward(0)
		area.kill()
		
		# Note: Eventually I want the levelRunner to lose lives based on enemy health
		get_tree().call_group("LevelRunner", "lose_life")
	pass # Replace with function body.
