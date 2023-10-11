extends Node2D

@export var enemyScene: PackedScene
@export var towerPlatformScene: PackedScene
@export var hudScene: PackedScene

var hud

var multipleEnemies = true # For debugging, only spawning one enemy

var lives = 5
var money = 100

signal gameOver
signal success
var gameOverFlag = false

var platformList = []


var totalEnemies = 10
var timeDelay = 1.0


# Called when the node enters the scene tree for the first time.
func _ready():
	set_up_towers()
	
	add_to_group("CurrentLevel")
	
	hud = hudScene.instantiate()
	add_child(hud)
	
	reset()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
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
	
	platformList.append(p1)
	platformList.append(p2)
	platformList.append(p3)
	platformList.append(p4)
	platformList.append(p5)
	
	add_child(p1)
	add_child(p2)
	add_child(p3)
	add_child(p4)
	add_child(p5)



func reset():
	$ResetButton.hide()
	$StartButton.show()
	$StartLabel.text = "Sushi Attack"
	get_tree().call_group("Enemies", "queue_free")
	get_tree().call_group("EnemyPathFollows", "set_in_destination")
	get_tree().call_group("EnemyPathFollows", "queue_free")
	for p in platformList:
		p.remove_tower()
	gameOverFlag = false
	hud.update_lives(lives)
	update_money_guis()
	
	lives = 5
	money = 100



func start_game():
	# reset everything if needed
	
	$EnemySpawnTimer.start(3)
	print("Started")


func stop_game():
	$EnemySpawnTimer.stop()
	if gameOverFlag:
		$StartLabel.text = "Game Over"
	else:
		$StartLabel.text = "Success!"
	$StartLabel.show()
	$ResetButton.show()


func subtract_money(m):
	money -= m
	update_money_guis()


func update_money_guis():
	hud.update_money(money)
	for p in platformList:
		p.update_buttons(money)




func _on_enemy_spawn_timer_timeout():
	# spawn enemy
	var enemy = enemyScene.instantiate()
	var pathFollow = enemy.get_path_follow()
		
	$EnemyPath.add_child(pathFollow)
	pathFollow.add_child(enemy)
		
	# reset the timer with a random value from 1 to 2
	$EnemySpawnTimer.start(randf() + timeDelay)
	
	totalEnemies -= 1
	timeDelay -= .1
	if totalEnemies <= 0:
		emit_signal("success")


func _on_enemy_destination_area_entered(area):
	if area.is_in_group("Enemies"):
		if !gameOverFlag:
			lives -= 1
			hud.update_lives(lives)
			if lives <= 0:
				emit_signal("gameOver")
		area.myPathFollow.in_destination = true
		area.myPathFollow.queue_free()
		area.queue_free()





func _on_game_over():
	print("Game Over!")
	gameOverFlag = true
	stop_game()




func _on_enemy_path_child_exiting_tree(node):
	if node.is_in_group("EnemyPathFollows"):
		# an enemy died, give you some money!
		if !node.in_destination:
			money += 10
			update_money_guis()



func _on_start_button_pressed():
	$StartButton.hide()
	$ResetButton.hide()
	$StartLabel.hide()
	start_game()


func _on_success():
	print("Success!")
	stop_game()


func _on_reset_button_pressed():
	reset()
	pass # Replace with function body.
