extends Area2D


func _ready():
	pass # Replace with function body.


func _process(delta):
	pass



func _on_area_entered(area):
	if area.is_in_group("Enemies"):
		area.multiply_speed(.5)
		


func _on_area_exited(area):
	if area.is_in_group("Enemies"):
		area.multiply_speed(2)
