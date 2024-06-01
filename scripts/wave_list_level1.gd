extends Node

const base_wave_entry = {
	"enemyName": null,
	"amount": null,
	"timer": null,
}

# Setting up our enemy waves
const wave1 = [
	{
		"enemyName": "bento_box",
		"amount": 4,
		"timer": 3
	}
]

const wave_list = [wave1]


func get_wave_list():
	return wave_list
