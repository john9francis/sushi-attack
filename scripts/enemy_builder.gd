extends Node2D

# This node will create one single enemy and it's pathFollow. 
#
# The purpose of this class is because initializing an enemy is
# complicated. We need an "enemyPathFollow" and an "enemy"
# as well as setting the enemies speed, health, animation textures, etc. 

@export var enemyScene: PackedScene
@export var pathFollowScene: PackedScene

var enemy
var pathFollow

signal enemyAnimSet
var animSet = false


# Premade enemies:
const base = {
	"spriteFrames": null,
	"speed": null,
	"health": null,
	"colissionRadius": null
}
const test1 = {
	"spriteFrames": preload("res://anims/test1.tres"),
	"speed": 5,
	"health": 3,
	"colissionRadius": 50
}
const test2 = {
	"spriteFrames": preload("res://anims/test2.tres"),
	"speed": 1,
	"health": 12,
	"colissionRadius": 70
}



func _ready():
	pass # Replace with function body.


func _process(delta):
	pass

func get_premade_enemy(enemyName):
	
	var premadeEnemy
	
	# first, set which premade enemy
	if enemyName == "test1":
		premadeEnemy = test1
	elif enemyName == "test2":
		premadeEnemy = test2
	else:
		premadeEnemy = null
		print("enemy_builder error, premade enemy does not exist")
		return
	
	# return the enemy created from the premade template
	var enemy = create_enemy(
		premadeEnemy["spriteFrames"],
		premadeEnemy["speed"],
		premadeEnemy["health"],
		premadeEnemy["colissionRadius"]
	)
	
	return enemy
	pass

func set_enemy(_preloadedSpriteFrames, _speed, _health, _colissionRadius=null):
	if enemy != null:
		print("Error, an enemy has already been set")
		return
	
	enemy = enemyScene.instantiate()
	pathFollow = pathFollowScene.instantiate()
	
	enemy.set_path_follow(pathFollow)
	enemy.set_speed(_speed)
	enemy.set_health(_health)
	
	enemy.set_anim(_preloadedSpriteFrames)
	enemy.set_sprite_size(_colissionRadius)
	
	pass

func create_enemy(_preloadedSpriteFrames, _speed, _health, _colissionRadius=0):
	var new_enemy = enemyScene.instantiate()
	var new_pathFollow = pathFollowScene.instantiate()
	
	new_enemy.set_path_follow(new_pathFollow)
	new_enemy.set_speed(_speed)
	new_enemy.set_health(_health)
	
	new_enemy.set_anim(_preloadedSpriteFrames)
	
	if _colissionRadius != 0:
		new_enemy.set_colission_radius(_colissionRadius)
	
	new_enemy.set_enemy_created_flag(true)
	
	return new_enemy

func delete_enemy():
	if enemy != null:
		enemy.kill()


func get_enemy():
	if enemy != null:
		return enemy
	else:
		print("enemy_builder Error: enemy not set correctly")


