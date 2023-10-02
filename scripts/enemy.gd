extends Area2D

@export var myPathFollowScene: PackedScene
var myPathFollow

const speed = 5
var currentSpeed = 5
var health = 5
var poisoned = false
var poison_hits = 0

func _ready():
	add_to_group("Enemies")
	


func _process(_delta):
	if health <= 0:
		queue_free()
	

func set_speed(s):
	currentSpeed = s
	myPathFollow.set_speed(currentSpeed)


func get_path_follow():
	myPathFollow = myPathFollowScene.instantiate()
	myPathFollow.set_speed(currentSpeed)
	return myPathFollow


func multiply_speed(s):
	currentSpeed *= s
	myPathFollow.set_speed(currentSpeed)
	
	


func _on_body_entered(body):
	if body.is_in_group("Bullets"):
		body.queue_free()
		health -= 1




func _on_area_entered(area):
	if area.is_in_group("Explosions"):
		print("Poisoned!")
		poison_hits = 5
		$PoisonTimer.start()



func _on_poison_timer_timeout():
	health -= 1
	poison_hits -= 1
	print("Poison Hit")
	
	if poison_hits <= 0:
		$PoisonTimer.stop()
