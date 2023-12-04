extends Area2D

@export var TrackerScene: PackedScene

var tracker
var enemyTracked
var enemyList = []
var enemyToKillPos

var readyToKill

var killMobTime
var handSpeed

var handAtRest

var blankTexture

var spriteScale

@onready var changeDirectionTimer = $ChangeDirectionTimer
@onready var towerSize = $TowerSize
@onready var towerAnim = $TowerAnim

enum State {READY, MOVING, HAS_ENEMY, NOT_READY}
var previousState;
var currentState;

func _ready():
	# disable handArea RB collisions, it's only for setting linear velocity
	$CS_Hand/CollisionShape2D.disabled = true
	
	set_sprite_size()
	towerAnim.play("ready")
	previousState = State.READY
	currentState = State.READY
	
	handSpeed = 100
	killMobTime = 5
	
	# Tracker settings
	readyToKill = true
	enemyTracked = false
	handAtRest = true
	tracker = TrackerScene.instantiate()
	add_child(tracker)
	
	# Set the CS Connector lines (aka chopsticks)
	$CS_Connector.set_point_position(0, Vector2())
	$CS_Connector.set_point_position(1, $CS_Hand.position)
	$CS_Connector2.set_point_position(0, Vector2())
	$CS_Connector2.set_point_position(1, $CS_Hand.position)
	
	
	changeDirectionTimer.start(randf() * 10)



func _process(delta):
	if enemyList.size() > 0:
		tracker.set_area(enemyList[0])
		enemyToKillPos = tracker.get_target_future_pos(20)
	else:
		enemyToKillPos = null
		
		
	var direction = (global_position - $CS_Hand.global_position).normalized()
		
		
	if (global_position - $CS_Hand.global_position).length() >= Vector2(handSpeed/50,handSpeed/50).length():
		# the case where the hand is moving back to spawn
		move_hand(direction)
		if currentState != State.MOVING:
			currentState = State.MOVING
			
	else:
		# the case where the hand is not moving
		move_hand(Vector2())
		if !readyToKill:
			currentState = State.NOT_READY
			
			# make sure the chopstick hand doesn't have the sushi sprite
			$CS_Hand/Sprite2D.set_texture(blankTexture)
		else:
			currentState = State.READY
		
		
	# the case where it's chasing the enemy
	if readyToKill and enemyToKillPos != null:
		direction = (enemyToKillPos - $CS_Hand.global_position).normalized()
		move_hand(direction)
		if currentState != State.MOVING:
			currentState = State.MOVING
			
		
		
	# Make the visual chopsticks follow the tracker
	var cs1pos = $CS_Hand.position - 15*Vector2(-direction.x, direction.y)
	var cs2pos = $CS_Hand.position - 15*Vector2(direction.x, -direction.y)
	$CS_Connector.set_point_position(1, cs1pos)
	$CS_Connector2.set_point_position(1, cs2pos)
	
	
	# update the anim based on the enum
	if currentState != previousState:
		change_anim(currentState)
		previousState = currentState
		pass
	

func change_anim(newEnum):
	var animName = ""
	
	if newEnum == State.READY:
		animName = "ready"
		
	elif newEnum == State.NOT_READY:
		animName = "not_ready"
		
	elif newEnum == State.MOVING:
		animName = "moving"
		
	towerAnim.play(animName)

	
func upgrade():
	handSpeed *= 1.5
	killMobTime *= .75
	$cs_range.apply_scale(Vector2(1.25,1.25))
	pass


func set_sprite_size():
	# Set the sprite size to match the colissionbox size
	var collisionWidth = towerSize.shape.get_radius() * 2
	var spriteTexture = towerAnim.sprite_frames.get_frame_texture("ready",0)
	var spriteScale = 1.1 * Vector2(
		collisionWidth / spriteTexture.get_width(), 
		collisionWidth / spriteTexture.get_height())
	
	towerAnim.set_scale(spriteScale)


func _on_kill_mob_timer_timeout():
	readyToKill = true
	
	# update the enum
	currentState = State.READY
	
	#reactivate handArea colissions
	$CS_Hand/HandArea/CollisionShape2D.disabled = false
	
	#reset cs hand
	$CS_Hand/Sprite2D.set_texture(blankTexture)
	$CS_Hand.rotation = 0



func _on_area_entered(area):
	if area.is_in_group("Enemies"):
		enemyList.append(area)



func _on_area_exited(area):
	if enemyList.has(area):
		enemyList.erase(area)





func move_hand(direction):
	$CS_Hand.linear_velocity = direction * handSpeed
	pass

func _on_hand_area_area_entered(area):
	if area.is_in_group("Enemies") and readyToKill:
		
		area.myPathFollow.queue_free()
		readyToKill = false
		$KillMobTimer.start(killMobTime)
		
		# Set the hand texture to the enemy's texture
		var collisionShape = $CS_Hand/CollisionShape2D.get_shape()
		var collisionWidth = collisionShape.get_radius() * 2
		var enemyTexture = area.get_enemy_texture()
		
		var spriteScale = Vector2(
			collisionWidth / enemyTexture.get_width(), 
			collisionWidth / enemyTexture.get_height())
	
		$CS_Hand/Sprite2D.set_texture(enemyTexture)
		$CS_Hand/Sprite2D.set_scale(spriteScale)
		
		# disable area to prevent bugs
		$CS_Hand/HandArea/CollisionShape2D.call_deferred("set_disabled", true)
		
	pass # Replace with function body.




func _on_change_direction_timer_timeout():
	towerAnim.scale.x *= -1
	
	changeDirectionTimer.start(randf()*10)
