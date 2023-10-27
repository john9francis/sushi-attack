extends Area2D

@export var TrackerScene: PackedScene

var tracker
var enemyTracked
var enemyList = []
var enemyToKillPos

var readyToKill

var handSpeed

var handAtRest

var blankTexture


func _ready():
	# debug
	$debugTimer.start()
	
	handSpeed = 100
	
	blankTexture = $CS_Hand/Sprite2D.get_texture()
	$CS_Hand/Sprite2D.set_texture(blankTexture)
	
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


func _process(delta):
	if enemyList.size() > 0:
		tracker.set_area(enemyList[0])
		enemyToKillPos = tracker.get_target_future_pos(20)
	else:
		enemyToKillPos = null
		
		
	var direction = (global_position - $CS_Hand.global_position).normalized()
		
		
	if (global_position - $CS_Hand.global_position).length() >= Vector2(handSpeed/50,handSpeed/50).length():
		move_hand(direction)
	else:
		move_hand(Vector2())
		
	if readyToKill and enemyToKillPos != null:
		direction = (enemyToKillPos - $CS_Hand.global_position).normalized()
		move_hand(direction)
		
		
	# Make the chopsticks follow the tracker
	var cs1pos = $CS_Hand.position - 15*Vector2(-direction.x, direction.y)
	var cs2pos = $CS_Hand.position - 15*Vector2(direction.x, -direction.y)
	$CS_Connector.set_point_position(1, cs1pos)
	$CS_Connector2.set_point_position(1, cs2pos)
	


func set_upgrade_level(level):
	match level:
		1: print("Level one!")
		2: print("Level two!")
		3: print("Level three!")
		4: print("Max level!")
	pass


func _on_kill_mob_timer_timeout():
	readyToKill = true
	$CS_Hand/Sprite2D.set_texture(blankTexture)
	$CS_Hand.rotation = 0



func _on_area_entered(area):
	if area.is_in_group("Enemies"):
		enemyList.append(area)
		
	#if readyToKill:
	#	if area.is_in_group("Enemies"):
	#		area.myPathFollow.queue_free()
	#		readyToKill = false
	#		$KillMobTimer.start()




func _on_area_exited(area):
	if enemyList.has(area):
		enemyList.erase(area)



func _on_debug_timer_timeout():
	#print(enemyList)
	pass # Replace with function body.



func move_hand(direction):
	$CS_Hand.linear_velocity = direction * handSpeed
	pass

func _on_hand_area_area_entered(area):
	if area.is_in_group("Enemies") and readyToKill:
		area.myPathFollow.queue_free()
		readyToKill = false
		$KillMobTimer.start()
		
		# Set the hand texture to the enemy's texture
		var collisionShape = $CS_Hand/CollisionShape2D.get_shape()
		var collisionWidth = collisionShape.get_radius() * 2
		var enemyTexture = area.get_enemy_texture()
		
		var spriteScale = Vector2(
			collisionWidth / enemyTexture.get_width(), 
			collisionWidth / enemyTexture.get_height())
	
		$CS_Hand/Sprite2D.set_texture(enemyTexture)
		$CS_Hand/Sprite2D.set_scale(spriteScale)
		
	pass # Replace with function body.
