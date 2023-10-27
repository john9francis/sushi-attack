extends Area2D

@export var BulletScene: PackedScene
@export var ExplosionScene: PackedScene
@export var TrackerScene: PackedScene

var secondsToImpact
var bulletList = []

var tracker
var enemyList = []

# Called when the node enters the scene tree for the first time.
func _ready():
	tracker = TrackerScene.instantiate()
	add_child(tracker)
	
	secondsToImpact = 1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if enemyList.size() > 0:
		tracker.set_area(enemyList[0])
		if $ShootTimer.is_stopped():
			$ShootTimer.start()
	else:
		$ShootTimer.stop()
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
		enemyList.append(area)


func _on_area_exited(area):
	if area.is_in_group("Enemies"):
		if enemyList.has(area):
			enemyList.erase(area)


func _on_shoot_timer_timeout():
	var enemyGlobalPosition = tracker.get_target_future_pos(70)
	var enemyLocalPosition = to_local(enemyGlobalPosition)
	
	# Shoot a bullet in an arc
	var bullet = BulletScene.instantiate()
	bullet.remove_from_group("Bullets") # so it doesn't damage enemy
	bullet.gravity_scale = 1
	bullet.position = position
	
	# Direct the bullet in an arc toward the enemy
	
	# NOTE: I need to multiply by delta in here somewhere...
	# because it only works for 1 second to impact
	# I may not be able to use "secondsToImpact" and rather do a "speed"
	# I could make v = speed, and then calculate vx and vy
	
	var vx = enemyLocalPosition.x / secondsToImpact
	var vy = - 0.5 * 980 * bullet.gravity_scale / (secondsToImpact*secondsToImpact) + enemyLocalPosition.y / secondsToImpact
	bullet.linear_velocity = Vector2(vx, vy)
	
	bullet.set_destination(enemyGlobalPosition)
	
	bulletList.append(bullet)
	add_child(bullet)
	$ExplodeTimerManager.start_explosion_timer(secondsToImpact)



func _on_explode_timer_manager_explosion_timer_timeout():
	var explosion = ExplosionScene.instantiate()
	
	var bullet = bulletList[0]
	var bpos = bullet.position
	
	explosion.position = bpos
	add_child(explosion)
	
	bulletList[0].queue_free()
	bulletList.erase(bulletList[0])
