extends Node2D

@export var enemyScene: PackedScene
@export var towerPlatformScene: PackedScene
@export var hudScene: PackedScene
@export var levelSetupScene: PackedScene
var levelSetup

@export var enemyBuilderScene: PackedScene
var enemyBuilder

var hud

var multipleEnemies = true # For debugging, only spawning one enemy

var lives
var money

signal gameOver
signal success

signal setupLevel

var gameOverFlag = false
var gameStoppedFlag = true

var platformList = []

var totalEnemies
var currentEnemies = totalEnemies
var enemySpawnTimeDelay

var enemyDestinationPosition

var waves = []
var sequentialWaves = []
var currentWave
var totalWaves


func setup_level(levelName):
	# instantiate the level setup and get the correct level
	levelSetup = levelSetupScene.instantiate()
	levelSetup.request_level(levelName)
	
	# set up the waves
	waves = levelSetup.get_wave_list()
	currentWave = 0
	totalWaves = waves.size()
	
	# set up the progress bar wave text
	$ProgressBar/Label.text = "Wave: %i / %i" %[currentWave+1, totalWaves+1]
	
	setup_sequential_waves()
	
	print(totalEnemies)
	emit_signal("setupLevel")
	
func setup_sequential_waves():
	# for reference:
	#"enemyName": "test1",
	#"amount": 10,
	#"timer": 1
	
	sequentialWaves.clear()
	
	for wave in waves:
		var s_wave = []
		
		for waveObj in wave:
			var enemyName = waveObj["enemyName"]
			var enemyAmount = waveObj["amount"]
			var enemyTimer = waveObj["timer"]
			for i in range(enemyAmount):
				s_wave.append(enemyName)
				s_wave.append(enemyTimer)
		
		sequentialWaves.append(s_wave)
		
		
	totalEnemies = 0
	for wave in sequentialWaves:
		totalEnemies += wave.size()/2
				


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("CurrentLevel")
	
	hud = hudScene.instantiate()
	add_child(hud)
	
	enemyBuilder = enemyBuilderScene.instantiate()
	
	# Set enemy destination now that we're ready
	$EnemyDestination.position = enemyDestinationPosition

	# keep enemyDestination on screen
	if $EnemyDestination.position.y > get_viewport_rect().size.y:
		$EnemyDestination.position.y = get_viewport_rect().size.y
	if $EnemyDestination.position.y < 0:
		$EnemyDestination.position.y = 0
	if $EnemyDestination.position.x > get_viewport_rect().size.x:
		$EnemyDestination.position.x = get_viewport_rect().size.x
	if $EnemyDestination.position.x < 0:
		$EnemyDestination.position.x = 0
	
	reset()
	pass


func _on_setup_level():
	
	var setup_platforms = levelSetup.get_tower_platforms()
	for setup_platform in setup_platforms:
		
		var real_platform = towerPlatformScene.instantiate()
		real_platform.set_position(setup_platform.get_position())
		
		add_child(real_platform)
		platformList.append(real_platform)
		
	# setup the curve2d
	var pathCurve = levelSetup.get_path_curve()
	$EnemyPath.curve = pathCurve
	
	# make sure the destination is at the end of the curve
	var last_point_idx = pathCurve.get_point_count() - 1
	var last_point_position = pathCurve.get_point_position(last_point_idx)

	enemyDestinationPosition = last_point_position
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func reset():
	$StartButton.show()
	$ResetButton.hide()
	$ProgressBar.hide()
	$StartLabel.text = "Sushi Attack"
	
	get_tree().call_group("EnemyPathFollows", "set_reward", 0)
	get_tree().call_group("EnemyPathFollows", "set_in_destination")
	get_tree().call_group("Enemies", "kill")
	
	for p in platformList:
		p.remove_tower()
		
	gameOverFlag = false
	
	setup_sequential_waves()
	currentWave = 0
	
	currentEnemies = totalEnemies
	enemySpawnTimeDelay = 2
	
	lives = 5
	money = 150
	
	hud.update_lives(lives)
	update_money_guis()



func start_game():
	gameStoppedFlag = false
	$ProgressBar.show()
	$ProgressBar/Label.show()
	
	$EnemySpawnTimer.start(3)
	print("Started")


func stop_game():
	gameStoppedFlag = true
	$EnemySpawnTimer.stop()
	


func subtract_money(m):
	money -= m
	update_money_guis()


func update_money_guis():
	hud.update_money(money)
	for p in platformList:
		p.update_buttons(money)
		


func _on_enemy_spawn_timer_timeout():
	# update the progress bar wave text
	$ProgressBar/Label.text = "Wave: %i / %i" %[currentWave+1, totalWaves+1]
	
	# spawn enemy and set timer based on the sequential waves
	var wave = sequentialWaves[currentWave]
	
	var enemyName = wave[0]
	wave.remove_at(0)
	var delayTime = wave[0]
	wave.remove_at(0)
	
	sequentialWaves[currentWave] = wave
	
	# spawn enemy
	var enemy = enemyBuilder.get_premade_enemy(enemyName)
	var pathFollow = enemy.get_path_follow()
		
	$EnemyPath.add_child(pathFollow)
	pathFollow.add_child(enemy)
		
	# reset the timer with a random value from 1 to 2
	if wave.size() > 0:
		$EnemySpawnTimer.start(randf() + delayTime)
	elif currentWave + 1 == waves.size():
		currentEnemies = 0
		return
	else:
		currentWave += 1
		$EnemySpawnTimer.start(10)
		
		
	# update the progress bar
	$ProgressBar.progress(float(totalEnemies), float(totalEnemies - wave.size()/2))
	
	


func _on_enemy_destination_area_entered(area):
	if area.is_in_group("Enemies"):
		if !gameOverFlag:
			lives -= 1
			hud.update_lives(lives)
			if lives <= 0:
				emit_signal("gameOver")
		area.myPathFollow.in_destination = true
		area.kill()





func _on_game_over():
	print("Game Over!")
	gameOverFlag = true
	get_tree().call_group("MainHud", "game_over")
	stop_game()




func _on_enemy_path_child_exiting_tree(node):
	if node.is_in_group("EnemyPathFollows"):
		# an enemy died, give you some money!
		if !node.in_destination:
			money += node.get_reward()
			update_money_guis()
			
		# You win if you kill the last enemy
		if currentEnemies <= 0 and !get_tree().has_group("Enemies") and !gameOverFlag:
			emit_signal("success")
	



func _on_start_button_pressed():
	$StartButton.hide()
	$ResetButton.hide()
	$StartLabel.hide()
	$ProgressBar.value = 0
	start_game()


func _on_success():
	print("Success!")
	# tell main hud to show the success screen
	get_tree().call_group("MainHud", "success")
	stop_game()


func _on_reset_button_pressed():
	stop_game()
	reset()
	pass # Replace with function body.


func _on_tree_exiting():
	remove_from_group("CurrentLevel")
	pass # Replace with function body.
