extends Area2D

@onready var explosionAnim = $explosionAnim

# Called when the node enters the scene tree for the first time.
func _ready():
	$DespawnTimer.start()
	explosionAnim.play("explosion")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_despawn_timer_timeout():
	#queue_free()
	pass # Replace with function body.


func _on_explosion_anim_animation_finished():
	queue_free()
	pass # Replace with function body.
