extends RigidBody2D

var enemyToFollow

# Called when the node enters the scene tree for the first time.
func _ready():
	enemyToFollow = null
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_follow_enemy(enemy):
	enemyToFollow = enemy
	pass
