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
const maki = {
	"spriteFrames": preload("res://anims/maki.tres"),
	"speed": 2,
	"health": 5,
	"reward": 10,
	"colissionRadius": 40
}
const rice_ball = {
	"spriteFrames": preload("res://anims/rice_ball.tres"),
	"speed": 1,
	"health": 25,
	"reward": 30,
	"colissionRadius": 60
}
const pink_maki = {
	"spriteFrames": preload("res://anims/pmaki.tres"),
	"speed": 5,
	"health": 5,
	"reward": 20,
	"colissionRadius": 30
}


func _ready():
	pass # Replace with function body.


func _process(delta):
	pass

func get_premade_enemy(enemyName):
	
	var premadeEnemy
	
	# first, set which premade enemy
	if enemyName == "maki":
		premadeEnemy = maki
	elif enemyName == "rice_ball":
		premadeEnemy = rice_ball
	elif enemyName == "pink_maki":
		premadeEnemy = pink_maki
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

