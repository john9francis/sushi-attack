extends Area2D

@export var TrackerScene: PackedScene

var tracker
var enemyTracked
var enemyList = []
var enemyToKillPos

var readyToKill

func _ready():
	# debug
	$debugTimer.start()
	
	readyToKill = true
	enemyTracked = false
	tracker = TrackerScene.instantiate()
	add_child(tracker)
	
	$CS_Connector.set_point_position(0, Vector2())
	$CS_Connector.set_point_position(1, $CS_Hand.position)


func _process(delta):
	if enemyList.size() > 0:
		tracker.set_area(enemyList[0])
		enemyToKillPos = tracker.get_target_future_pos()
		if $HandTimer.is_stopped():
			$HandTimer.start()
	elif !$HandTimer.is_stopped():
		$HandTimer.stop()
		
		
	# Make the hand follow the tracker
	$CS_Connector.set_point_position(1, $CS_Hand.position)
	
	


func _on_kill_mob_timer_timeout():
	readyToKill = true



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


func _on_hand_timer_timeout():
	
	var direction = (enemyToKillPos - $CS_Hand.global_position).normalized()
	
	# Make the hand go toward the target
	$CS_Hand.linear_velocity = direction * 50
	
	pass # Replace with function body.
