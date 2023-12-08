extends Node

const base_wave_entry = {
	"enemyName": null,
	"amount": null,
	"timer": null,
}

# Setting up our enemy waves
const wave1 = [
	{
		"enemyName": "pink_maki",
		"amount": 5,
		"timer": 1
	}
]
const wave2 = [
	{
		"enemyName": "maki",
		"amount": 10,
		"timer": 1
	},
	{
		"enemyName": "rice_ball",
		"amount": 5,
		"timer": 1
	}
]
const wave3 = [
	{
		"enemyName": "maki",
		"amount": 5,
		"timer": 1
	},
	{
		"enemyName": "rice_ball",
		"amount": 5,
		"timer": 1
	},
	{
		"enemyName": "maki",
		"amount": 5,
		"timer": 1
	}
]
const wave4 = [
	{
		"enemyName": "rice_ball",
		"amount": 12,
		"timer": 1
	},
	{
		"enemyName": "pink_maki",
		"amount": 10,
		"timer": 2
	}
]
const wave_list = [wave1, wave2, wave3, wave4]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func get_wave_list():
	return wave_list
