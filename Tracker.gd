extends Node

var areaToTrack
var areaExists

# Called when the node enters the scene tree for the first time.
func _ready():
	areaExists = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if areaExists:
		print(areaToTrack.global_position)


func set_area(area):
	areaToTrack = area
	areaExists = true
	
func unset_area():
	areaToTrack = null
	areaExists = false
