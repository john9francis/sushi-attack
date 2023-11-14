extends Node2D

@export var towerPlatformScene : PackedScene

var enemyPaths = []
var towerPlatforms = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_premade_level(premadeLevel):
	
	# Set up the paths
	var premadeEnemyPaths = premadeLevel.get_enemy_paths()
	
	for path in premadeEnemyPaths:
		var p = Path2D.new()
		
		p.set_curve(path.get_curve())
		
		enemyPaths.append(p)
		add_child(p)
		
	# Set up the tower platforms
	var premadeTowerPlatforms = premadeLevel.get_tower_platform_list()
	
	for platform in premadeTowerPlatforms:
		var tp = towerPlatformScene.instantiate()
		
		tp.position = platform.position
		
		towerPlatforms.append(tp)
		add_child(tp)
	pass