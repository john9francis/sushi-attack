extends Node
# This class is for upgrading towers
signal upgrade
signal max_upgrade

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _upgrade():
	emit_signal("upgrade")
