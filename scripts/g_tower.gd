extends Area2D

@export var BulletScene: PackedScene
@export var TrackerScene: PackedScene

var tracker
var enemyTracked
var enemyList = []

var shootSeconds
var bulletSpeed

@onready var towerAnim = $TowerSize/towerAnim
@onready var blinkTimer = $BlinkTimer

var anims = [
	preload("res://anims/g_tower.tres"),
	preload("res://anims/g_tower_up1.tres"),
	preload("res://anims/g_tower_up2.tres")
]

var currentAnimIndx = 0
var shootDespawnTime


# Called when the node enters the scene tree for the first time.
func _ready():
	shootSeconds = .66
	bulletSpeed = 500
	shootDespawnTime = .75
	
	# set the shootTimer wait time
	$ShootTimer.wait_time = shootSeconds
	
	enemyTracked = false
	tracker = TrackerScene.instantiate()
	add_child(tracker)
	
	blinkTimer.start(randf() * 5)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if enemyList.size() > 0:
		tracker.set_area(enemyList[0])
		if $ShootTimer.is_stopped():
			$ShootTimer.start()
	else:
		$ShootTimer.stop()
		

func upgrade():
	shootSeconds *= .65
	$ShootTimer.wait_time = shootSeconds
	shootDespawnTime *= 1.65
	
	currentAnimIndx += 1
	set_tower_anim(anims[currentAnimIndx])
	
	towerAnim.play("idle")
	


func set_tower_anim(newAnim):
	towerAnim.sprite_frames = newAnim
	pass


func _on_shoot_timer_timeout():
	# Get where the enemy currently is
	var enemyPos = tracker.get_target_future_pos(15)
	var direction = (enemyPos - global_position).normalized()
	
	# Create a bullet and shoot it 
	var bullet = BulletScene.instantiate()
	bullet.add_to_group("Bullets")
	bullet.position = position
	bullet.linear_velocity = direction * bulletSpeed
	
	add_child(bullet)
	bullet.activate_despawn_timer(.65)
	bullet.set_color(Color.HOT_PINK)
	
	towerAnim.play("shoot")
	




func _on_area_entered(area):
	if area.is_in_group("Enemies"):
		enemyList.append(area)
	



func _on_area_exited(area):
	if area.is_in_group("Enemies"):
		if enemyList.has(area):
			enemyList.erase(area)


func _on_tower_anim_animation_finished():
	towerAnim.play("idle")
	pass # Replace with function body.


func _on_blink_timer_timeout():
	if randf() > .3:
		towerAnim.play("blink")
	else:
		towerAnim.scale.x *= -1
	blinkTimer.start(randf() * 5)
	pass # Replace with function body.
