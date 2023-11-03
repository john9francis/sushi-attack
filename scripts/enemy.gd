extends Area2D

@export var myPathFollowScene: PackedScene
var myPathFollow

@onready var enemyAnim = $EnemyAnimation

var speed = 1
var currentSpeed = speed
var health = 1
var poison_hits = 0

var temporarySpeed = 0

var spriteFrames

var enemySetFlag


func _ready():
	enemySetFlag = false
	
	set_speed(currentSpeed)
	
	# Set the sprite size to match the colissionbox size
	var collisionShape = $CollisionShape2D.get_shape()
	var collisionWidth = collisionShape.get_radius() * 2
	var spriteTexture = $EnemyAnimation.sprite_frames.get_frame_texture("maki_right_down",0)
	var spriteScale = 1.1 * Vector2(
		collisionWidth / spriteTexture.get_width(), 
		collisionWidth / spriteTexture.get_height())
	
	$EnemyAnimation.set_scale(spriteScale)
	
	$EnemyAnimation.play("maki_right_down")



func _process(_delta):
	if health <= 0:
		myPathFollow.queue_free()
		

func kill():
	# kill the enemy
	myPathFollow.queue_free()
	queue_free()
		
		
func set_enemy(_speed=2, _health=10):
	# Almost a constructor for the enemies
	# Things to set:
	# 1. texture
	# 2. speed
	# 3. health
	# 4. special stuff (I'll figure that out later)
	# note: I have to set the names of the animations the same...
	# I need "right down", "left up" and everything in between
	
	speed = _speed
	currentSpeed = speed	
	myPathFollow.set_speed(currentSpeed)
	health = _health
	
	enemySetFlag = true
	
func set_path_follow(pathFollow):
	myPathFollow = pathFollow
	pass
	
func get_enemy():
	# Returns a list with the enemy as first arg and the pathfollow as second arg
	
	pass


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
	
	
func restore_speed():
	currentSpeed = speed
	myPathFollow.set_speed(currentSpeed)
	

func get_enemy_texture():
	return $EnemyAnimation.sprite_frames.get_frame_texture("maki_right_down",0)
	
func pause():
	temporarySpeed = myPathFollow.get_speed()
	set_speed(0)
	
func resume():
	set_speed(temporarySpeed)
	

func _on_body_entered(body):
	if body.is_in_group("Bullets"):
		body.queue_free()
		health -= 1




func _on_area_entered(area):
	if area.is_in_group("Explosions"):
		poison_hits = 5
		$PoisonTimer.start()



func _on_poison_timer_timeout():
	health -= 1
	poison_hits -= 1
	
	if poison_hits <= 0:
		$PoisonTimer.stop()


