extends Area2D

@export var myPathFollowScene: PackedScene
var myPathFollow

@onready var enemyAnim = $EnemyAnimation
@onready var enemyHitbox = $CollisionShape2D
@onready var tracker = $Tracker
@onready var healthBar = $HealthBar
@onready var poisonAnim = $poisonAnim

var green = Color.GREEN_YELLOW
var black = Color.DIM_GRAY
var baseColor

var speed = 1
var currentSpeed = speed
var health = 1
var currentHealth = health
var poison_hits = 0
var reward = 0

var temporarySpeed = 0

var spriteFrames
var animSet = false

var enemySetFlag = false

signal resize_enemy_sprite

var facingRight = true


func _ready():
	#enemyAnim.play("right-down")
	emit_signal("resize_enemy_sprite")
	
	# set the tracker to this enemy so we can get it's velocity
	tracker.set_area(self)
	
	poisonAnim.hide()
	poisonAnim.play("fire")
	
	baseColor = $EnemyAnimation.self_modulate
	


func _process(_delta):
	if currentHealth <= 0:
		kill()
		
	# update progress bar
	healthBar.value = currentHealth
		
	# Get the direction vector
	var direction = Vector2(.5, .5)
	
	if tracker.get_target_future_pos() != null:
		
		direction = (tracker.get_target_pos() - tracker.get_target_future_pos()).normalized()
	
	# set our anim name
	var animName = get_correct_anim(get_anim_name(direction))
	
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
	
	var padding = .1 
	# This is basically how close to the x or y axis you need
	# to be to play the up down left right axis.
	# lower number favors the in-between anims.
	# higher number favors the up-down-left-right anims.
	
	var up = PI/2
	var left = 0
	var down = -PI/2
	var positiveRight = PI
	var negativeRight = -PI

	var angle = direction.angle()


	if angle < left + padding and angle > left - padding:
		anim_name = "left"
	elif angle < up + padding and angle > up - padding:
		anim_name = "up"
	elif angle < negativeRight + padding or angle > positiveRight - padding:
		anim_name = "right"
	elif angle < down + padding and angle > down - padding:
		anim_name = "down"
	
	# now that we dealt with the cardinal directions, it's easy to figure out
	# the in-between directions. 
	elif angle > up:
		anim_name = "right-up"
	elif angle < down:
		anim_name = "right-down"
	elif angle > 0:
		anim_name = "left-up"
	else:
		anim_name = "left-down"

	return anim_name

	

func set_enemy_created_flag(t_or_false):
	enemySetFlag = t_or_false

func kill():
	# let any children know that we're dying
	for c in get_children():
		if c.has_method("kill"):
			c.kill()
	# kill the enemy
	myPathFollow.queue_free()
	queue_free()
	
func lose_health(val):
	currentHealth -= val
	
func set_anim(preloadedFrames):
	$EnemyAnimation.set_sprite_frames(preloadedFrames)
	animSet = true
	pass
	
	
func get_anim_set_flag():
	return animSet
	
func set_health(h):
	health = h
	currentHealth = health
	
	# update progress bar
	$HealthBar.min_value = 0
	$HealthBar.max_value = health
	

func set_colission_radius(value):
	value = float(value)
	$CollisionShape2D.shape.set_radius(value)
	pass

func set_reward(r):
	#myPathFollow.set_reward(r)
	reward = r
	

func get_current_health():
	return currentHealth


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
		
		# put the health bar above the sprite
		healthBar.position.y = - collisionWidth / 2 - 10
	
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
	
func set_color(color=baseColor):
	enemyAnim.self_modulate = color
	

func get_enemy_texture():
	return enemyAnim.sprite_frames.get_frame_texture("right-down",0)
	
	
	

func _on_body_entered(body):
	if body.is_in_group("Bullets"):
		body.queue_free()
		lose_health(1)



func _on_area_entered(area):
	if area.is_in_group("Explosions"):
		poison_hits = 4
		$PoisonTimer.start()
		poisonAnim.show()
		enemyAnim.self_modulate = green


func _on_poison_timer_timeout():
	currentHealth -= 1
	poison_hits -= 1
	
	if poison_hits <= 0:
		$PoisonTimer.stop()
		poisonAnim.hide()
		enemyAnim.self_modulate = baseColor



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
