extends Node2D

@export var towerPlatformScene : PackedScene
@export var enemyDestinationScene : PackedScene

@onready var enemySpawnTimer = $EnemySpawnTimer
@onready var levelSetup = $LevelSetup
@onready var enemyBuilder = $EnemyBuilder
@onready var waveTimer = $WaveTimer

var enemyPaths = []
var towerPlatforms = []
var waveList = []
var sequentialWaves = []
var enemyDestinations = []

var enemiesOnScreen = 0

var currentWave
var totalWaves

@onready var moneyLabel = $hudPanel/MoneyLabel
@onready var livesLabel = $hudPanel/LivesLabel
@onready var progressBar = $hudPanel/ProgressBar
@onready var wavesLabel = $hudPanel/ProgressBar/WavesLabel

var money = 150
var lives = 5

var gameOverFlag = false
var successFlag = false
var lastEnemySpawnedFlag = false

signal game_over_signal
signal success_signal



func _ready():
	update_labels()
	progressBar.hide()


func _process(delta):
	update_labels()
	if lastEnemySpawnedFlag and enemiesOnScreen == 0 and !gameOverFlag and !successFlag:
		success()
	pass
	

func update_labels():
	moneyLabel.text = "Money: {m}".format({"m": str(money)})
	livesLabel.text = "Lives: {l}".format({"l": str(lives)})
	
	for c in get_children():
		if c.is_in_group("TowerPlatforms"):
			c.update_buttons(money)
	pass
	

func subtract_money(cost):
	money -= cost

func add_money(amount):
	money += amount

func set_premade_level(premadeLevelName):
	
	# set the level in our levelSetup
	levelSetup.set_level(premadeLevelName)
	
	# Set up the paths
	var premadeEnemyPaths = levelSetup.get_enemy_paths()
	
	for path in premadeEnemyPaths:
		var p = Path2D.new()
		
		p.set_curve(path.get_curve())
		
		enemyPaths.append(p)
		add_child(p)
		
		# add some enemy destinations to the end of the paths
		var pathCurve = path.get_curve()
		var last_point_idx = pathCurve.get_point_count() - 1
		var last_point_position = pathCurve.get_point_position(last_point_idx)
		
		var enemyDestination = enemyDestinationScene.instantiate()
		enemyDestination.position = last_point_position
		add_child(enemyDestination)
		enemyDestinations.append(enemyDestination)

	
		
	# Set up the tower platforms
	var premadeTowerPlatforms = levelSetup.get_tower_platform_list()
	
	for platform in premadeTowerPlatforms:
		var tp = towerPlatformScene.instantiate()
		
		tp.position = platform.position
		
		towerPlatforms.append(tp)
		add_child(tp)
		
		
	
	# Set up the sequential enemy list
	waveList = levelSetup.get_wave_list()
	sequentialWaves = setup_sequential_waves(waveList)
	totalWaves = waveList.size()
	
	pass



func setup_sequential_waves(nonSequentialWaves):
	# Sets up the waves in the form: enemy, timer, enemy, timer
	
	# for reference:
	#"enemyName": "test1",
	#"amount": 10,
	#"timer": 1
	
	var _sequential_waves = []
	
	for wave in nonSequentialWaves:
		var s_wave = []
		
		for waveObj in wave:
			var enemyName = waveObj["enemyName"]
			var enemyAmount = waveObj["amount"]
			var enemyTimer = waveObj["timer"]
			for i in range(enemyAmount):
				s_wave.append(enemyName)
				s_wave.append(enemyTimer)
		
		_sequential_waves.append(s_wave)
		
	return _sequential_waves
	
	
func start_game():
	
	print("Game started")
	currentWave = 0
	enemySpawnTimer.start(1)
	
	progressBar.show()
	set_progress_bar_to_wave(currentWave + 1)

func set_progress_bar_to_wave(currentWave):
	wavesLabel.text = "Wave: " + str(currentWave) + "/" + str(totalWaves)
	pass

func _on_enemy_spawn_timer_timeout():
	# spawn enemy and set timer based on the sequential waves
	
	# Step 1: get the wave, the enemy, and the timer
	var wave = sequentialWaves[currentWave]
	
	var enemyName = wave[0]
	wave.remove_at(0)
	var delayTime = wave[0]
	wave.remove_at(0)
	
	sequentialWaves[currentWave] = wave
	
	# spawn enemy
	var enemy = enemyBuilder.get_premade_enemy(enemyName)
	var pathFollow = enemy.get_path_follow()
	
	# add the enemy to a random path
	var random_index = randi() % enemyPaths.size()
	var enemyPath = enemyPaths[random_index]
		
		
	enemyPath.add_child(pathFollow)
	pathFollow.add_child(enemy)
		
	# End the wave if we're out of enemies
	if wave.size() == 0:
		print("Wave ended")
		
		currentWave += 1

		# if this was the last wave, end here
		if currentWave == sequentialWaves.size():
			lastEnemySpawnedFlag = true;
			return
		# Otherwise, start the next wave:
		else:
			waveTimer.start(10)
			
	# If there's more enemies, start the enemyTimer again
	else:
		enemySpawnTimer.start(randf() + delayTime)
		
	
		
		


func _on_wave_timer_timeout():
	print("Next wave started!")
	enemySpawnTimer.start(1)
	pass # Replace with function body.
	
	
func clear_level():	
	
	reset()
	
	# Basically delete any added nodes
	for i in enemyPaths:
		i.queue_free()
	for i in towerPlatforms:
		i.queue_free()
	for i in enemyDestinations:
		i.queue_free()
		
	enemyPaths = []
	towerPlatforms = []
	waveList = []
	sequentialWaves = []
	enemyDestinations = []
	
	pass


func reset():
	print("Resetting")
	for c in get_children():
		if c is Timer:
			c.stop()
	
	get_tree().call_group("TowerPlatforms", "remove_tower")
	get_tree().call_group("Enemies", "set_reward", 0)
	get_tree().call_group("Enemies", "kill")
	
	money = 150
	lives = 5
	currentWave = 0
	
	sequentialWaves = setup_sequential_waves(waveList)
	
	gameOverFlag = false
	successFlag = false
	lastEnemySpawnedFlag = false
	

func lose_life():
	if lives > 0:
		lives -= 1
	
	if lives <= 0 and !gameOverFlag:
		game_over()


func game_over():
	print("Game Over")
	
	gameOverFlag = true
	
	for c in get_children():
		if c is Timer:
			c.stop()
	
	emit_signal("game_over_signal")
			
func success():
	print("Success")
	
	successFlag = true
	
	emit_signal("success_signal")
	

# Functions called by enemy scene
func enemy_joining():
	enemiesOnScreen += 1
	pass
	
func enemy_leaving():
	enemiesOnScreen -= 1
	pass
