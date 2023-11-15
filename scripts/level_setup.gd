extends Node2D

var level

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func get_premade_level(levelName):
	if levelName == "Level1":
		return $Level1


func set_level(levelName):
	if levelName == "Level1":
		level = $Level1
	elif levelName == "Level2":
		level = $Level2


func get_enemy_paths():
	var pathList = []
	
	for c in level.get_children():
		if c.is_class("Path2D"):
			pathList.append(c)
			
	return pathList


func get_tower_platform_list():
	var towerPlatformList = []
	
	for c in level.get_children():
		if c.is_in_group("TowerPlatforms"):
			towerPlatformList.append(c)
			
	return towerPlatformList
	

func get_wave_list():
	var wave_list
	
	for c in level.get_children():
		if c.is_in_group("WaveLists"):
			wave_list = c.get_wave_list()
			
	return wave_list
