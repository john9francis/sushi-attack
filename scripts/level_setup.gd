extends Node2D

var level
var levelList = []

func _ready():
	
	# Add all levels to the levelList
	for child in get_children():
		levelList.append(child.name)
		
	send_levels_to_level_menu()


func _process(delta):
	pass
	

func send_levels_to_level_menu():
	get_tree().call_group("MainGui", "populate_level_buttons", levelList)
	pass


func get_premade_level(levelName):
	if levelName == "Level1":
		return $Level1


func set_level(levelName):
	var requestedLevel = null
	
	for c in get_children():
		var level_name = c.get_name()
		if level_name == levelName:
			requestedLevel = c
	
	if requestedLevel == null:
		print("LevelSetup error: Tried to set up a level that doesn't exist")
		return
	
	level = requestedLevel


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

