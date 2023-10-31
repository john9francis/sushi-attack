extends Area2D

var slownessFactor
var enemyList = []

func _ready():
	slownessFactor = .65
	pass # Replace with function body.


func _process(delta):
	pass


func upgrade():
	slownessFactor *= slownessFactor
	$CollisionShape2D.apply_scale(Vector2(1.1,1.1))
	
	# Make sure we update all the enemies' speeds
	for enemy in enemyList:
		enemy.restore_speed()
		enemy.multiply_speed(slownessFactor)
	pass
	

func _on_area_entered(area):
	if area.is_in_group("Enemies"):
		area.multiply_speed(slownessFactor)
		enemyList.append(area)
		


func _on_area_exited(area):
	if area.is_in_group("Enemies"):
		area.restore_speed()
		if enemyList.has(area):
			enemyList.erase(area)
