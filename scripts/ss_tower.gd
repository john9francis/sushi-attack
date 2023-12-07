extends Area2D

var slownessFactor
var enemyList = []

@onready var slownessArea = $SlownessArea

func _ready():
	slownessFactor = .65
	pass # Replace with function body.


func _process(delta):
	pass


func upgrade():
	slownessFactor *= .8
	slownessArea.apply_scale(Vector2(1.2,1.2))
	
	# Make sure we update all the enemies' speeds
	for enemy in enemyList:
		enemy.restore_speed()
		enemy.multiply_speed(slownessFactor)
	pass
	

func _on_area_entered(area):
	if area.is_in_group("Enemies"):
		area.multiply_speed(slownessFactor)
		area.set_color(Color.DARK_SLATE_GRAY)
		
		if enemyList.size() == 0:
			slownessArea.play_anim("spread_out")
		
		enemyList.append(area)
		
	


func _on_area_exited(area):
	if area.is_in_group("Enemies"):
		area.restore_speed()
		area.set_color()
		
		if enemyList.has(area):
			enemyList.erase(area)
	
		if enemyList.size() == 0:
			slownessArea.play_anim("absorb")
