extends Node

var levelPath

var enemy_list = []
var tower_platform_list = []
var path_points_list = []

signal levelLoaded


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func set_level_path(levelName):
	levelPath = "res://levels/" + levelName + ".txt"
	levelLoaded.emit()
	pass


func load_level(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	return content


func get_enemy_list():
	pass


func get_tower_platform_list():
	pass
	

func get_path_points_list():
	return path_points_list
	pass
	
	
func get_enemy_path():
	# Get the "Path2D" object
	pass


func _on_level_loaded():
	var fileContent = load_level(levelPath)
	set_all_lists(fileContent)
	pass # Replace with function body.


func set_all_lists(fileContent):
	# reads the file and puts all the things into their lists
	var lines = fileContent.split("\n")
	
	var pathLines = false
	var enemyLines = false
	var towerPlatformLines = false
	
	for line in lines:
		# Get rid of whitespace
		line = line.strip_edges()
		
		if pathLines:
			var vectorStrings = line.split(",")
			var x = int(vectorStrings[0])
			var y = int(vectorStrings[1])
			var pathPointVector = Vector2(x,y)
			path_points_list.append(pathPointVector)
		
		if line == "path":
			pathLines = true
			enemyLines = false
			towerPlatformLines = false
			
		

	pass
