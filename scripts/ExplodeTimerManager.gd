extends Node

signal explosion_timer_timeout
var timerList = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func start_explosion_timer(seconds):
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	timer.connect("timeout", _on_explosion_timer_timeout)
	
	add_child(timer)
	timer.start(seconds)
	print("Timer started")
	pass


func _on_explosion_timer_timeout():
	print("explosion signal")
	emit_signal("explosion_timer_timeout")
	pass
