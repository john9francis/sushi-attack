extends Node2D

@export var enemyScene: PackedScene
var multipleEnemies = true # For debugging, only spawning one enemy

var points = 0

var enemyList = []
var pathFollowList = []

# Called when the node enters the scene tree for the first time.
func _ready():
	$EnemySpawnTimer.start()
	print("Started")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
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
	
	
