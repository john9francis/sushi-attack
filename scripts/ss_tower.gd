extends Area2D

var slownessFactor

func _ready():
	slownessFactor = .6
	pass # Replace with function body.


func _process(delta):
	pass


func upgrade():
	slownessFactor *= slownessFactor
	$CollisionShape2D.apply_scale(Vector2(1.1,1.1))
	pass
	

func _on_area_entered(area):
	if area.is_in_group("Enemies"):
		area.multiply_speed(slownessFactor)
		


func _on_area_exited(area):
	if area.is_in_group("Enemies"):
		area.multiply_speed(1/slownessFactor)
