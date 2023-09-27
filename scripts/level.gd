extends Node2D

@export var enemyScene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$EnemySpawnTimer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_enemy_spawn_timer_timeout():
	var enemy = enemyScene.instantiate()
	$EnemyPath.add_child(enemy)
