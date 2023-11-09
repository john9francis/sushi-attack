extends Node2D

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
	"reward": null,
	"colissionRadius": null
}
const test1 = {
	"spriteFrames": preload("res://anims/test1.tres"),
	"speed": 5,
	"health": 3,
	"reward": 15,
	"colissionRadius": 30
}
const test2 = {
	"spriteFrames": preload("res://anims/test2.tres"),
	"speed": 1,
	"health": 20,
	"reward": 20,
	"colissionRadius": 50
}
const test3 = {
	"spriteFrames": preload("res://Assets/maki-walk1/maki_walk1.tres"),
	"speed": 2,
	"health": 8,
	"reward": 10,
	"colissionRadius": 40
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
	elif enemyName == "test3":
		premadeEnemy = test3
	else:
		premadeEnemy = null
		print("enemy_builder error, premade enemy does not exist")
		return
	
	# return the enemy created from the premade template
	var enemy = create_enemy(
		premadeEnemy["spriteFrames"],
		premadeEnemy["speed"],
		premadeEnemy["health"],
		premadeEnemy["reward"],
		premadeEnemy["colissionRadius"]
	)
	
	return enemy


func create_enemy(_preloadedSpriteFrames, _speed, _health, _reward=10, _colissionRadius=0):
	var new_enemy = enemyScene.instantiate()
	var new_pathFollow = pathFollowScene.instantiate()
	
	new_enemy.set_path_follow(new_pathFollow)
	new_enemy.set_speed(_speed)
	new_enemy.set_health(_health)
	new_enemy.set_reward(_reward)
	
	new_enemy.set_anim(_preloadedSpriteFrames)
	
	if _colissionRadius != 0:
		new_enemy.set_colission_radius(_colissionRadius)
	
	new_enemy.set_enemy_created_flag(true)
	
	return new_enemy

