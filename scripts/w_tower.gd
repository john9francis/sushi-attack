extends Area2D

@export var ExplosionScene: PackedScene
@export var TrackerScene: PackedScene

var tracker

# Called when the node enters the scene tree for the first time.
func _ready():
	tracker = TrackerScene.instantiate()
	add_child(tracker)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_area_entered(area):
	if area.is_in_group("Enemies"):
		tracker.set_area(area)
		$ShootTimer.start()


func _on_area_exited(area):
	if area.is_in_group("Enemies"):
		tracker.unset_area()
		$ShootTimer.stop()


func _on_shoot_timer_timeout():
	var enemyGlobalPosition = tracker.get_target_pos()
	var enemyLocalPosition = to_local(enemyGlobalPosition)
	
	var explosion = ExplosionScene.instantiate()
	explosion.position = enemyLocalPosition
	
	add_child(explosion)
