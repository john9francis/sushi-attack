extends Node

const base_wave_entry = {
	"enemyName": null,
	"amount": null,
	"timer": null,
}

const wave1 = [
	{
		"enemyName": "test1",
		"amount": 10,
		"timer": 1
	},
	{
		"enemyName": "test2",
		"amount": 2,
		"timer": 3
	}
]

const wave_list = [wave1]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_wave_list():
	return wave_list
