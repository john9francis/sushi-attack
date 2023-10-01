extends Area2D

@export var ExplosionScene: PackedScene
@export var TrackerScene: PackedScene

var tracker

# Called when the node enters the scene tree for the first time.
func _ready():
	tracker = TrackerScene.instantiate()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_area_entered(area):
	if area.is_in_group("Enemies"):
		tracker.set_area(area)
	pass # Replace with function body.


func _on_area_exited(area):
	if area.is_in_group("Enemies"):
		tracker.unset_area()
	pass # Replace with function body.
