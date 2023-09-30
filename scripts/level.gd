extends Node2D

@export var enemyScene: PackedScene
@export var towerPlatformScene: PackedScene
var multipleEnemies = true # For debugging, only spawning one enemy

var points = 0

var enemyList = []
var pathFollowList = []

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
	p4.position = Vector2(500, 850)
	p5.position = Vector2(800, 820)
	
	add_child(p1)
	add_child(p2)
	add_child(p3)
	add_child(p4)
	add_child(p5)
	

# Called when the node enters the scene tree for the first time.
func _ready():
	$EnemySpawnTimer.start()
	print("Started")




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# Make the enemies advance
	for path in pathFollowList:
		path.progress += 5
	pass


func _on_enemy_spawn_timer_timeout():
	if (multipleEnemies):
		var enemy = enemyScene.instantiate()
		#$EnemyPath.add_child(enemy)
		var pathFollow = PathFollow2D.new()
		pathFollow.add_child(enemy)
	
		$EnemyPath.add_child(pathFollow)
		
		pathFollowList.append(pathFollow)
		#multipleEnemies = false


func _on_enemy_destination_area_entered(area):
	# note: 'area' refers to the enemydestination
	points += 1
	print(points)
	area.queue_free()
	
	
