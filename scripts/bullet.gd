extends RigidBody2D

var destination
@onready var bulletSprite = $Sprite2D
@onready var despawnTimer = $DespawnTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position == destination:
		print("In destination")
	pass

func set_color(color):
	bulletSprite.self_modulate = color


func set_destination(vector):
	# Sets the destination, prints when the bullet hits there
	destination = vector
	pass

func disable_collision():
	$CollisionShape2D.disabled = true
	
func activate_despawn_timer(time):
	despawnTimer.start(time)


func _on_despawn_timer_timeout():
	queue_free()
	pass # Replace with function body.
