extends Node

var levelPaths = {
	"level1" : "res://created_levels/level1.json"
}

var currentLevelPath

var paths = []
var plates = []
var waves = []

func _ready():
	set_level("level1")
	load_level()
	pass


func _process(delta):
	pass
	

func set_level(levelName):
	if levelName in levelPaths:
		currentLevelPath = levelPaths[levelName]
	else:
		print("level loader error: set_level called on an unknown level")


func load_level():
	# loads the currentLevel
	if currentLevelPath == null:
		print("level loader error: No level set")
		return
		
	if not FileAccess.file_exists(currentLevelPath):
		print("level loader error: level path does not exist")
		return
		
	# get the level from the json file
	var loadedLevel = FileAccess.open(currentLevelPath, FileAccess.READ)
	var levelText = loadedLevel.get_as_text()
	var json = JSON.new()
	# save it to a dictionary. keys = "name", "paths", "plates", "waves"
	var levelObject = json.parse_string(levelText)
	
	paths = levelObject["paths"]
	plates = levelObject["plates"]
	waves = levelObject["waves"]
	
	print(paths)
	
	
	
	
	
