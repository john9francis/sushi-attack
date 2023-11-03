extends Node2D

# This node will create one single enemy and it's pathFollow. 

@export var enemyScene: PackedScene
@export var pathFollowScene: PackedScene

var enemy
var pathFollow

func _ready():
	pass # Replace with function body.


func _process(delta):
	pass


func set_enemy(_speed, _health):
	if enemy != null:
		print("Error, an enemy has already been set")
		return
	
	enemy = enemyScene.instantiate()
	pathFollow = pathFollowScene.instantiate()
	
	enemy.set_path_follow(pathFollow)
	enemy.set_speed(_speed)
	enemy.set_health(_health)
	pass


func get_enemy():
	if enemy != null:
		return [enemy, pathFollow]
	else:
		print("enemy_builder Error: enemy not set correctly")
