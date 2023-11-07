extends Node2D

var levelName
var levelOptions = ["L1", "L2", "L3"]

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func request_level(_levelName):
	if _levelName in levelOptions:
		levelName = _levelName
	else:
		print("level_setup Error, tried to initialize level not an option")
	pass



func get_path_curve():
	if levelName == "L1":
		return $L1/Path2D.curve
	elif levelName == "L2":
		return $L2/Path2D.curve
	else: 
		print("level_setup error, path doesn't exist")
	pass
	
	
	
func get_tower_platforms():
	var towerList = []
	
	var levelObject
	if levelName == "L1":
		levelObject = $L1
	elif levelName == "L2":
		levelObject = $L2
	else:
		print("level_setup error, no level to get towers from")
		return 
		
	
	for c in levelObject.get_children():
		if c.is_in_group("TowerPlatforms"):
			towerList.append(c)
			#print(c, " added to level_setup")
		
	return towerList
	
	
	
func get_enemy_list():
	pass
