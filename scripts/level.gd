extends Node2D

@export var enemyScene: PackedScene
@export var towerPlatformScene: PackedScene
@export var enemyPathFollowScene: PackedScene

var multipleEnemies = true # For debugging, only spawning one enemy

var points = 0

var enemyList = []
var pathFollowList = []



# Called when the node enters the scene tree for the first time.
func _ready():
	$EnemySpawnTimer.start()
	print("Started")

	set_up_towers()


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
	p5.position = Vector2(810, 820)
	
	add_child(p1)
	add_child(p2)
	add_child(p3)
	add_child(p4)
	add_child(p5)


func _on_enemy_spawn_timer_timeout():
	# spawn enemy
	if (multipleEnemies):
		var enemy = enemyScene.instantiate()
		var pathFollow = enemy.get_path_follow()
		
		$EnemyPath.add_child(pathFollow)
		pathFollow.add_child(enemy)
		
		multipleEnemies = false


func _on_enemy_destination_area_entered(area):
	if area.is_in_group("Enemies"):
		points += 1
		print(points)
		area.queue_free()
	
	
