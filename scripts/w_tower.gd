extends Area2D

@export var BulletScene: PackedScene
@export var ExplosionScene: PackedScene
@export var TrackerScene: PackedScene

@onready var towerAnim = $wTowerAnim
@onready var towerSize = $TowerSize

@onready var shootTimer = $ShootTimer

# for starting the anim one second before the bullet goes off
@onready var animStartTimer = $wTowerAnim/AnimStartTimer
@onready var changeDirectionTimer = $changeDirectionTimer

var secondsToImpact
var bulletList = []

var tracker
var enemyList = []

var shootTime
var stopAnimFlag = false

var readyToShoot = false
var playingShootingAnim = false

var anims = [
	preload("res://anims/w_tower.tres"),
	preload("res://anims/w_tower_up1.tres"),
	preload("res://anims/w_tower_up2.tres")
]

var currentAnimIndx = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	currentAnimIndx = 0
	
	tracker = TrackerScene.instantiate()
	add_child(tracker)
	
	shootTime = 2.5
	#shootTimer.wait_time = shootTime
	shootTimer.start(shootTime)
	
	secondsToImpact = 1
	
	set_anim_scale()
	towerAnim.play("idle")
	
	changeDirectionTimer.start(randf() * 10)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if enemyList.size() > 0:
		tracker.set_area(enemyList[0])
		
		if readyToShoot:
			towerAnim.play("shooting")
			playingShootingAnim = true
			readyToShoot = false
			
		if shootTimer.is_stopped():
			shootTimer.start(shootTime)
			
	
	
func set_shoot_anim_in_motion():
	var reducedShootTime = shootTime - .5
	if reducedShootTime <= 0:
		reducedShootTime = .1
		
	# set the anim speed so it ends right as we shoot
	set_animation_duration(shootTime - reducedShootTime)
	animStartTimer.start(reducedShootTime)
	pass


func set_animation_duration(durationSeconds):
	var frame_count = 8.0

	# Calculate frames per second to achieve the desired duration
	var fps = frame_count / durationSeconds

	# Set the animation speed
	towerAnim.sprite_frames.set_animation_speed("shooting", fps)


func set_anim_scale():
	# Set the sprite size to match the colissionbox size
	var collisionWidth = towerSize.shape.get_radius() * 2
	var spriteTexture = towerAnim.sprite_frames.get_frame_texture("idle",0)
	var spriteScale = 1.1 * Vector2(
		collisionWidth / spriteTexture.get_width(), 
		collisionWidth / spriteTexture.get_height())
	
	towerAnim.set_scale(spriteScale)


func upgrade():
	shootTime *= .85
	$ShootTimer.wait_time = shootTime
	$CollisionShape2D.apply_scale(Vector2(1.1,1.1))
	
	currentAnimIndx += 1
	set_tower_anim(anims[currentAnimIndx])
	
	# make it a little bigger
	towerAnim.set_scale(towerAnim.scale * 1.2)
	

func set_tower_anim(newAnim):
	towerAnim.sprite_frames = newAnim


func _on_area_entered(area):
	if area.is_in_group("Enemies"):
		enemyList.append(area)


func _on_area_exited(area):
	if area.is_in_group("Enemies"):
		if enemyList.has(area):
			enemyList.erase(area)


func _on_shoot_timer_timeout():
	readyToShoot = true
	

func shoot():
	var enemyGlobalPosition = tracker.get_target_future_pos(70)
	
	if enemyGlobalPosition == null:
		return
	
	var enemyLocalPosition = to_local(enemyGlobalPosition)
	
	# Shoot a bullet in an arc
	var bullet = BulletScene.instantiate()
	bullet.remove_from_group("Bullets") # so it doesn't damage enemy
	bullet.gravity_scale = 1
	bullet.disable_collision() # make sure it doesn't collide with other bullets
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
	bullet.set_color(Color.GREEN)
	
	$ExplodeTimerManager.start_explosion_timer(secondsToImpact)
	pass



func _on_explode_timer_manager_explosion_timer_timeout():
	var explosion = ExplosionScene.instantiate()
	
	var bullet = bulletList[0]
	var bpos = bullet.position
	
	explosion.position = bpos
	add_child(explosion)
	
	bulletList[0].queue_free()
	bulletList.erase(bulletList[0])


func _on_anim_start_timer_timeout():
	towerAnim.play("shooting")
	pass # Replace with function body.


func _on_change_direction_timer_timeout():
	towerAnim.scale.x *= -1
	
	changeDirectionTimer.start(randf()*10)




func _on_w_tower_anim_animation_finished():
	if playingShootingAnim:
		shoot()
		playingShootingAnim = false
	pass # Replace with function body.
