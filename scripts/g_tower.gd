extends Area2D

@export var BulletScene: PackedScene
@export var TrackerScene: PackedScene

var tracker
var enemyTracked
var enemyList = []

# Called when the node enters the scene tree for the first time.
func _ready():
	enemyTracked = false
	tracker = TrackerScene.instantiate()
	add_child(tracker)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if enemyList.size() > 0:
		tracker.set_area(enemyList[0])
		if $ShootTimer.is_stopped():
			$ShootTimer.start()
	else:
		$ShootTimer.stop()



func _on_shoot_timer_timeout():
	# Get where the enemy currently is
	var enemyPos = tracker.get_target_future_pos(15)
	var direction = (enemyPos - global_position).normalized()
	
	# Create a bullet and shoot it 
	var bullet = BulletScene.instantiate()
	bullet.position = position
	bullet.linear_velocity = direction * 800
	
	add_child(bullet)
	




func _on_area_entered(area):
	if area.is_in_group("Enemies"):
		enemyList.append(area)
	



func _on_area_exited(area):
	if area.is_in_group("Enemies"):
		if enemyList.has(area):
			enemyList.erase(area)
