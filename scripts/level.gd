extends Node2D

@export var enemyScene: PackedScene
@export var towerPlatformScene: PackedScene
@export var hudScene: PackedScene
@export var levelCreatorScene: PackedScene

var hud

var multipleEnemies = true # For debugging, only spawning one enemy

var lives
var money

signal gameOver
signal success
var gameOverFlag = false
var gameStoppedFlag = true

var platformList = []

const totalEnemies = 50
var currentEnemies = totalEnemies
var timeDelay


# Called when the node enters the scene tree for the first time.
func _ready():
	set_up_towers()
	#set_up_level("L1")
	
	add_to_group("CurrentLevel")
	
	hud = hudScene.instantiate()
	add_child(hud)
	
	reset()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
	
func set_up_level(fileName):
	# Starts up a levelCreator, get's all the info, then deletes it.
	var levelCreator = levelCreatorScene.instantiate()
	levelCreator.set_level_path(fileName)
	
	var pathPoints = levelCreator.get_path_points_list()
	#var path = Path2D.new()
	var curve = Curve2D.new()
	for point in pathPoints:
		curve.add_point(point)
	
	$EnemyPath.set_curve(curve)
	
	levelCreator.queue_free()
	pass




func set_up_towers():
	# Set up tower platforms
	var p1 = towerPlatformScene.instantiate()
	var p2 = towerPlatformScene.instantiate()
	var p3 = towerPlatformScene.instantiate()
	var p4 = towerPlatformScene.instantiate()
	var p5 = towerPlatformScene.instantiate()
	var p6 = towerPlatformScene.instantiate()
	var p7 = towerPlatformScene.instantiate()
	var p8 = towerPlatformScene.instantiate()
	var p9 = towerPlatformScene.instantiate()
	var p10 = towerPlatformScene.instantiate()
	
	p1.position = Vector2(100, 250)
	p2.position = Vector2(400, 450)
	p3.position = Vector2(600, 500)
	p4.position = Vector2(450, 850)
	p5.position = Vector2(750, 750)
	p6.position = Vector2(700, 250)
	p7.position = Vector2(850, 350)
	p8.position = Vector2(300, 620)
	p9.position = Vector2(150, 720)
	p10.position = Vector2(900, 550)
	
	platformList.append(p1)
	platformList.append(p2)
	platformList.append(p3)
	platformList.append(p4)
	platformList.append(p5)
	platformList.append(p6)
	platformList.append(p7)
	platformList.append(p8)
	platformList.append(p9)
	platformList.append(p10)
	
	add_child(p1)
	add_child(p2)
	add_child(p3)
	add_child(p4)
	add_child(p5)
	add_child(p6)
	add_child(p7)
	add_child(p8)
	add_child(p9)
	add_child(p10)



func reset():
	$StartButton.show()
	$ResetButton.hide()
	$ProgressBar.hide()
	$StartLabel.text = "Sushi Attack"
	
	get_tree().call_group("EnemyPathFollows", "set_value", 0)
	get_tree().call_group("EnemyPathFollows", "set_in_destination")
	get_tree().call_group("EnemyPathFollows", "queue_free")
	get_tree().call_group("Enemies", "queue_free")
	
	for p in platformList:
		p.remove_tower()
		
	gameOverFlag = false
	
	lives = 5
	money = 150
	
	currentEnemies = totalEnemies
	timeDelay = 1.5
	
	hud.update_lives(lives)
	update_money_guis()



func start_game():
	gameStoppedFlag = false
	$ProgressBar.show()
	$EnemySpawnTimer.start(3)
	print("Started")


func stop_game():
	gameStoppedFlag = true
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
		

func pause():
	print("Paused")
	# pause the towers
	
	# pause the enemies




func _on_enemy_spawn_timer_timeout():
	# spawn enemy
	var enemy = enemyScene.instantiate()
	var pathFollow = enemy.get_path_follow()
		
	$EnemyPath.add_child(pathFollow)
	pathFollow.add_child(enemy)
	
	currentEnemies -= 1
	timeDelay -= .015
		
	# reset the timer with a random value from 1 to 2
	if currentEnemies > 0:
		$EnemySpawnTimer.start(randf() + timeDelay)
		
	# update the progress bar
	$ProgressBar.progress(float(totalEnemies), float(totalEnemies - currentEnemies))
	
	


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
			money += node.value
			update_money_guis()
			
		# You win if you kill the last enemy
		if currentEnemies <= 0 and !get_tree().has_group("Enemies") and !gameOverFlag:
			emit_signal("success")
	



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
