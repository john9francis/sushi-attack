extends Node2D

# Base node for wave setup

var wave_list = []

const base_wave_entry = {
	"enemyName": null,
	"amount": null,
	"timer": null,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_wave_list():
	return wave_list
	
func set_wave_list(_list):
	wave_list = _list
	pass
