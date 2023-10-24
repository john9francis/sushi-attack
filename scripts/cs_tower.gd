extends Area2D

@export var TrackerScene: PackedScene

var tracker
var enemyTracked
var enemyList = []

var readyToKill

func _ready():
	# debug
	$debugTimer.start()
	
	readyToKill = true
	enemyTracked = false
	tracker = TrackerScene.instantiate()
	add_child(tracker)


func _process(delta):
	if enemyList.size() > 0:
		tracker.set_area(enemyList[0])



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
	print(enemyList)
	pass # Replace with function body.
