extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Bento box generated")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func kill():
	# spawn 3 new rolls
	print("Bye bento")
	for i in range(3):
		var enemyBuilder = get_tree().get_nodes_in_group("EnemyBuilder")[0]
	
		var enemyNames = ["maki", "maki", "gyoza"]
		var enemyName = enemyNames[randi() % enemyNames.size()]
	
		var enemy = enemyBuilder.get_premade_enemy(enemyName)
		var pathFollow = enemy.get_path_follow()
	
		# set the new enemy to the same path and same progress
		var thisEnemy = find_parent("Enemy")
		var thisPathFollow = thisEnemy.get_path_follow()
		var thisPath = thisPathFollow.find_parent("Path")
	
		thisPath.add_child(pathFollow)
		pathFollow.add_child(enemy)
	
		pathFollow.set_progress(thisPathFollow.get_progress())
