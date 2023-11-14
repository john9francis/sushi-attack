extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func get_enemy_paths():
	var pathList = []
	
	for c in get_children():
		if c.is_class("Path2D"):
			pathList.append(c)
			
	return pathList


func get_tower_platform_list():
	return [$towerPlatform, $towerPlatform2, $towerPlatform3]