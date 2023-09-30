extends Area2D

var readyToKill

# Called when the node enters the scene tree for the first time.
func _ready():
	$KillMobTimer.start()
	readyToKill = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_kill_mob_timer_timeout():
	readyToKill = true
	pass # Replace with function body.




func _on_area_entered(area):
	if readyToKill:
		if area.is_in_group("Enemies"):
			area.queue_free()
			readyToKill = false
