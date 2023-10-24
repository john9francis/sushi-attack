extends Area2D

@export var BulletScene: PackedScene
@export var ExplosionScene: PackedScene
@export var TrackerScene: PackedScene


var tracker
var enemyList = []

# Called when the node enters the scene tree for the first time.
func _ready():
	tracker = TrackerScene.instantiate()
	add_child(tracker)
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




func _on_area_entered(area):
	if area.is_in_group("Enemies"):
		enemyList.append(area)


func _on_area_exited(area):
	if area.is_in_group("Enemies"):
		if enemyList.has(area):
			enemyList.erase(area)


func _on_shoot_timer_timeout():
	var enemyGlobalPosition = tracker.get_target_future_pos()
	var enemyLocalPosition = to_local(enemyGlobalPosition)
	
	var explosion = ExplosionScene.instantiate()
	explosion.position = enemyLocalPosition
	
	add_child(explosion)
