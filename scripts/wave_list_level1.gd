extends Node

const base_wave_entry = {
	"enemyName": null,
	"amount": null,
	"timer": null,
}

# Setting up our enemy waves
const wave1 = [
	{
		"enemyName": "gyoza",
		"amount": 4,
		"timer": 3
	},
	{
		"enemyName": "maki",
		"amount": 5,
		"timer": 2
	},
	{
		"enemyName": "maki",
		"amount": 5,
		"timer": 1
	}
]
const wave2 = [
	{
		"enemyName": "pink_maki",
		"amount": 3,
		"timer": 4
	},
	{
		"enemyName": "maki",
		"amount": 5,
		"timer": 2
	},
	{
		"enemyName": "pink_maki",
		"amount": 7,
		"timer": 3
	},
]

const wave3 = [
	{
		"enemyName": "rice_ball",
		"amount": 5,
		"timer": 4
	},
	{
		"enemyName": "pink_maki",
		"amount": 7,
		"timer": 3
	},
	{
		"enemyName": "maki",
		"amount": 10,
		"timer": .5
	},
	{
		"enemyName": "rice_ball",
		"amount": 5,
		"timer": 2
	},
	{
		"enemyName": "pink_maki",
		"amount": 7,
		"timer": 1
	}
]

const wave_list = [wave1, wave2, wave3]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func get_wave_list():
	return wave_list
