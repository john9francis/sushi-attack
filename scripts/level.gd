extends Node2D

@export var enemyScene: PackedScene
var multipleEnemies = true # For debugging, only spawning one enemy

var points = 0

var enemyList = []

# Called when the node enters the scene tree for the first time.
func _ready():
	$EnemySpawnTimer.start()
	print("Started")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_enemy_spawn_timer_timeout():
	if (multipleEnemies):
		var enemy = enemyScene.instantiate()
		$EnemyPath.add_child(enemy)
		enemyList.append(enemy)
		
		#singleEnemy = false


func _on_enemy_destination_area_entered(area):
	# note: 'area' refers to the enemydestination
	points += 1
	print(points)

