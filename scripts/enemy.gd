extends Area2D

@export var myPathFollowScene: PackedScene
var myPathFollow

@onready var enemyAnim = $EnemyAnimation
@onready var enemyHitbox = $CollisionShape2D
@onready var tracker = $Tracker


var speed = 1
var currentSpeed = speed
var health = 1
var poison_hits = 0
var reward = 0

var temporarySpeed = 0

var spriteFrames
var animSet = false

var enemySetFlag = false

signal resize_enemy_sprite

var facingRight = true


func _ready():
	enemyAnim.play("right-down")
	emit_signal("resize_enemy_sprite")
	
	# set the tracker to this enemy so we can get it's velocity
	tracker.set_area(self)
	


func _process(_delta):
	if health <= 0:
		kill()
		
	# Get the direction vector
	var direction = Vector2(.5, .5)
	
	if tracker.get_target_future_pos() != null:
		
		direction = (tracker.get_target_pos() - tracker.get_target_future_pos()).normalized()
	
	# set our anim name
	var animName = get_correct_anim(get_anim_name(direction))
	
	

	# finally, play the correct anim
	enemyAnim.play(animName)
	
	
	
func get_correct_anim(animName):
	# handle the cases where we are moving left
	# note: I do this so I don't have to make anims for the left-moving sprites,
	# i just take the mirror image of the right-moving sprites.
	if animName == "left":
		animName = "right"
		if facingRight:
			facingRight = false
			enemyAnim.scale.x = -enemyAnim.scale.x
		
	elif animName == "left-up":
		animName = "right-up"
		if facingRight:
			facingRight = false
			enemyAnim.scale.x = -enemyAnim.scale.x
			
	elif animName == "left-down":
		animName = "right-down"
		if facingRight:
			facingRight = false
			enemyAnim.scale.x = -enemyAnim.scale.x
			
	else:
		if !facingRight:
			facingRight = true
			enemyAnim.scale.x = -enemyAnim.scale.x
			
	return animName
	
	
	
	
	
func get_anim_name(direction: Vector2):
	var anim_name = ""

	var angle = direction.angle()

	if angle < PI / 6 and angle > -PI / 6:
		anim_name = "left"
	elif angle > PI / 6 and angle < PI / 3:
		anim_name = "left-up"
	elif angle > PI / 3 and angle < 2 * PI / 3:
		anim_name = "up"
	elif angle > 2 * PI / 3 and angle < 5 * PI / 6:
		anim_name = "right-up"
	elif angle > 5 * PI / 6 or angle < -5 * PI / 6:
		anim_name = "right"
	elif angle > -5 * PI / 6 and angle < -2 * PI / 3:
		anim_name = "right-down"
	elif angle > -2 * PI / 3 and angle < -PI / 3:
		anim_name = "down"
	elif angle > -PI / 3 and angle < -PI / 6:
		anim_name = "left-down"

	return anim_name

	

func set_enemy_created_flag(t_or_false):
	enemySetFlag = t_or_false

func kill():
	# kill the enemy
	myPathFollow.queue_free()
	queue_free()
	
func set_anim(preloadedFrames):
	$EnemyAnimation.set_sprite_frames(preloadedFrames)
	animSet = true
	pass
	
func get_anim_set_flag():
	return animSet
	
func set_health(h):
	health = h
	

func set_colission_radius(value):
	value = float(value)
	$CollisionShape2D.shape.set_radius(value)
	pass

func set_reward(r):
	#myPathFollow.set_reward(r)
	reward = r



func set_sprite_size():
	if enemyAnim == null:
		print("enemy error, spriteFrames not set when trying to set sprite size")
		return
	else:
		# Set the sprite size to match the colissionbox size
		var collisionWidth = enemyHitbox.shape.get_radius() * 2
		var spriteTexture = enemyAnim.sprite_frames.get_frame_texture("right-down",0)
		var spriteScale = 1.1 * Vector2(
			collisionWidth / spriteTexture.get_width(), 
			collisionWidth / spriteTexture.get_height())
	
		enemyAnim.set_scale(spriteScale)
		
	
func set_path_follow(pathFollow):
	myPathFollow = pathFollow


func set_speed(s):
	speed = s
	currentSpeed = s
	myPathFollow.set_speed(currentSpeed)


func get_path_follow():
	return myPathFollow


func multiply_speed(s):
	currentSpeed *= s
	myPathFollow.set_speed(currentSpeed)
	
	
func restore_speed():
	currentSpeed = speed
	myPathFollow.set_speed(currentSpeed)
	

func get_enemy_texture():
	return enemyAnim.sprite_frames.get_frame_texture("right-down",0)
	
	
	

func _on_body_entered(body):
	if body.is_in_group("Bullets"):
		body.queue_free()
		health -= 1



func _on_area_entered(area):
	if area.is_in_group("Explosions"):
		poison_hits = 4
		$PoisonTimer.start()


func _on_poison_timer_timeout():
	health -= 1
	poison_hits -= 1
	
	if poison_hits <= 0:
		$PoisonTimer.stop()



func _on_resize_enemy_sprite():
	set_sprite_size()
	pass # Replace with function body.


func _on_tree_exiting():
	get_tree().call_group("LevelRunner", "add_money", reward)
	get_tree().call_group("LevelRunner", "enemy_leaving")
	pass # Replace with function body.


func _on_tree_entered():
	get_tree().call_group("LevelRunner", "enemy_joining")
	pass # Replace with function body.
