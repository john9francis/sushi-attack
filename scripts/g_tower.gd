extends Area2D

@export var BulletScene: PackedScene
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




func _on_shoot_timer_timeout():
	# Get where the enemy currently is
	var enemyPos = tracker.get_target_future_pos()
	var direction = (enemyPos - global_position).normalized()
	
	# Create a bullet and shoot it 
	var bullet = BulletScene.instantiate()
	bullet.position = position
	bullet.linear_velocity = direction * 800
	
	add_child(bullet)
	




func _on_area_entered(area):
	if area.is_in_group("Enemies"):
		$ShootTimer.start()	
		tracker.set_area(area)
	pass # Replace with function body.
	




func _on_area_exited(area):
	if area.is_in_group("Enemies"):
		$ShootTimer.stop()
		tracker.unset_area()
	pass # Replace with function body.
