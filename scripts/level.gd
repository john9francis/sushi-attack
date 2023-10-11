extends Node2D

@export var enemyScene: PackedScene
@export var towerPlatformScene: PackedScene
@export var hudScene: PackedScene

var hud

var multipleEnemies = true # For debugging, only spawning one enemy

var lives = 5
var money = 100

var enemyList = []
var pathFollowList = []

signal gameOver
var gameOverFlag = false


# Called when the node enters the scene tree for the first time.
func _ready():
	set_up_towers()
	
	$EnemySpawnTimer.start(1) # 1 seconds to start!
	print("Started")
	
	hud = hudScene.instantiate()
	add_child(hud)
	hud.update_lives(lives)
	hud.update_money(money)
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if lives <= 0:
		if !gameOverFlag:
			emit_signal("gameOver")
			gameOverFlag = true
			
		# reset lives
		lives = 5
	pass
	
	
func set_up_towers():
	# Set up tower platforms
	var p1 = towerPlatformScene.instantiate()
	var p2 = towerPlatformScene.instantiate()
	var p3 = towerPlatformScene.instantiate()
	var p4 = towerPlatformScene.instantiate()
	var p5 = towerPlatformScene.instantiate()
	
	p1.position = Vector2(100, 250)
	p2.position = Vector2(400, 450)
	p3.position = Vector2(600, 500)
	p4.position = Vector2(450, 850)
	p5.position = Vector2(750, 750)
	
	add_child(p1)
	add_child(p2)
	add_child(p3)
	add_child(p4)
	add_child(p5)


func _on_enemy_spawn_timer_timeout():
	# spawn enemy
	if (multipleEnemies):
		var enemy = enemyScene.instantiate()
		var pathFollow = enemy.get_path_follow()
		
		$EnemyPath.add_child(pathFollow)
		pathFollow.add_child(enemy)
		
		#multipleEnemies = false
		
		# reset the timer with a random value from 1 to 2
		$EnemySpawnTimer.start(randf() + 1)


func _on_enemy_destination_area_entered(area):
	if area.is_in_group("Enemies"):
		if !gameOverFlag:
			lives -= 1
			hud.update_lives(lives)
		area.myPathFollow.in_destination = true
		area.myPathFollow.queue_free()
		area.queue_free()
	
	
	


func _on_game_over():
	print("Game Over!")
	hud.update_lives("Game Over!")




func _on_enemy_path_child_exiting_tree(node):
	if node.is_in_group("EnemyPathFollows"):
		# an enemy died, give you some money!
		if !node.in_destination:
			money += 10
			hud.update_money(money)
