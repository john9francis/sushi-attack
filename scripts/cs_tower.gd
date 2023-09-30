extends Area2D

var readyToKill

func _ready():
	$KillMobTimer.start()
	readyToKill = true


func _process(delta):
	pass


func _on_kill_mob_timer_timeout():
	readyToKill = true



func _on_area_entered(area):
	if readyToKill:
		if area.is_in_group("Enemies"):
			area.queue_free()
			readyToKill = false
