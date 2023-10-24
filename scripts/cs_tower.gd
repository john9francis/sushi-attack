extends Area2D

@export var TrackerScene: PackedScene

var tracker
var enemyTracked
var enemyList = []

var readyToKill

func _ready():
	readyToKill = true
	enemyTracked = false
	tracker = TrackerScene.instantiate()
	add_child(tracker)


func _process(delta):
	pass


func _on_kill_mob_timer_timeout():
	readyToKill = true



func _on_area_entered(area):
	if readyToKill:
		if area.is_in_group("Enemies"):
			area.myPathFollow.queue_free()
			readyToKill = false
			$KillMobTimer.start()
