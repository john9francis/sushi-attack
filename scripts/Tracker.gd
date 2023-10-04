extends Node

var areaToTrack

var pastPosition
var currentPosition

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if areaToTrack != null:
		pastPosition = currentPosition
		currentPosition = areaToTrack.global_position


func set_area(area):
	areaToTrack = area
	
	
func unset_area():
	areaToTrack = null
	
func has_area():
	if areaToTrack == null:
		return false
	else:
		return true
	
	
func get_target_pos():
	return currentPosition
	
	
func get_target_future_pos(stepsAhead = 10):
	if !pastPosition:
		return currentPosition

	var velocity = currentPosition - pastPosition
	var futurePos = currentPosition + velocity * stepsAhead
	return futurePos
