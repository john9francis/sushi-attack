extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update_lives(lives):
	$Control/LivesControl/Lives.text = str(lives)


func update_money(money):
	$Control/MoneyControl/Money.text = str(money)
