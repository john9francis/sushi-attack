extends Node2D

@export var towerPlatformScene : PackedScene

var enemyPaths = []
var towerPlatforms = []
var sequentialEnemies = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_premade_level(premadeLevelName):
	
	var levelSetup = $LevelSetup
	
	# set the level in our levelSetup
	levelSetup.set_level(premadeLevelName)
	
	# Set up the paths
	var premadeEnemyPaths = levelSetup.get_enemy_paths()
	
	for path in premadeEnemyPaths:
		var p = Path2D.new()
		
		p.set_curve(path.get_curve())
		
		enemyPaths.append(p)
		add_child(p)
		
	# Set up the tower platforms
	var premadeTowerPlatforms = levelSetup.get_tower_platform_list()
	
	for platform in premadeTowerPlatforms:
		var tp = towerPlatformScene.instantiate()
		
		tp.position = platform.position
		
		towerPlatforms.append(tp)
		add_child(tp)
		
		
	
	# Set up the sequential enemy list
	
	pass
