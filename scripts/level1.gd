extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func get_enemy_paths():
	return [$Path1, $Path2]
	pass


func get_tower_platform_list():
	return [$towerPlatform, $towerPlatform2, $towerPlatform3]
