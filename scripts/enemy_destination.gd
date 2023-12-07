extends Area2D

var sprites = []
var currentSpritei = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	sprites = [$base, $crack1, $crack2, $crack3]
	
	reset()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reset():
	# hide all but the first
	for sprite in sprites:
		sprite.hide()
		
	currentSpritei = 0
	sprites[currentSpritei].show()
	


func _on_area_entered(area):
	if area.is_in_group("Enemies"):
		area.set_reward(0)
		area.kill()
		
		# Note: Eventually I want the levelRunner to lose lives based on enemy health
		get_tree().call_group("LevelRunner", "lose_life")
		
		possibly_break_plate()
	pass # Replace with function body.

func possibly_break_plate():
	if randf() < .7 and currentSpritei + 1 < sprites.size():
		sprites[currentSpritei].hide()
		currentSpritei += 1
		sprites[currentSpritei].show()
		
	pass
