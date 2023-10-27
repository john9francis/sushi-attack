extends Area2D


func _ready():
	pass # Replace with function body.


func _process(delta):
	pass


func set_upgrade_level(level):
	match level:
		1: print("Level one!")
		2: print("Level two!")
		3: print("Level three!")
		4: print("Max level!")
	pass
	

func _on_area_entered(area):
	if area.is_in_group("Enemies"):
		area.multiply_speed(.5)
		


func _on_area_exited(area):
	if area.is_in_group("Enemies"):
		area.multiply_speed(2)
