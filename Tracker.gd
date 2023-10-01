extends Node

var areaToTrack
var areaExists

var pastPosition
var currentPosition

# Called when the node enters the scene tree for the first time.
func _ready():
	areaExists = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if areaExists:
		pastPosition = currentPosition
		currentPosition = areaToTrack.global_position


func set_area(area):
	areaToTrack = area
	areaExists = true
	
func unset_area():
	areaToTrack = null
	areaExists = false
	
	
func get_target_pos():
	return currentPosition
	
func get_target_future_pos():
	if !pastPosition:
		return currentPosition

	var velocity = currentPosition - pastPosition
	var futurePos = currentPosition + velocity
	return futurePos
