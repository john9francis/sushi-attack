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

var currentWave;

@onready var moneyLabel = $MoneyLabel
@onready var livesLabel = $LivesLabel

var money = 150
var lives = 5

func _ready():
	update_labels()
	pass # Replace with function body.


func _process(delta):
	update_labels()
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
			print("Game over")
			return
		# Otherwise, start the next wave:
		else:
			waveTimer.start(10)
			
	# If there's more enemies, start the enemyTimer again
	else:
		enemySpawnTimer.start(randf() + delayTime)
		
	
#	if wave.size() > 0:
#		enemySpawnTimer.start(randf() + delayTime)
#	elif currentWave + 1 == sequentialWaves.size():
#		return
#	else:
#		currentWave += 1
#		waveTimer.start(10)
#		print("Wave timer started")
		
		


func _on_wave_timer_timeout():
	print("Next wave started!")
	enemySpawnTimer.start(1)
	pass # Replace with function body.
	
	
func clear_level():	
	# Basically delete any added nodes
	for i in enemyPaths:
		i.queue_free()
	for i in towerPlatforms:
		i.queue_free()
	for i in enemyDestinations:
		i.queue_free()
	for c in get_children():
		if c is Timer:
			c.stop()
		
	enemyPaths = []
	towerPlatforms = []
	waveList = []
	sequentialWaves = []
	enemyDestinations = []
	
	money = 150
	lives = 5

	currentWave = 0;
	pass


func reset():
	print("Resetting")
	for c in get_children():
		if c is Timer:
			c.stop()
	
	get_tree().call_group("TowerPlatforms", "remove_tower")
	get_tree().call_group("Enemies", "kill")
	
	money = 150
	lives = 5
	currentWave = 0
	
	sequentialWaves = setup_sequential_waves(waveList)
	

func lose_life():
	lives -= 1
