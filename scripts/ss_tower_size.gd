extends CollisionShape2D

@onready var towerAnim = $towerAnim

# Called when the node enters the scene tree for the first time.
func _ready():
	set_anim_scale()
	towerAnim.play("idle")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func set_anim_scale():
	# Set the sprite size to match the colissionbox size
	var collisionWidth = shape.get_radius() * 2
	var spriteTexture = towerAnim.sprite_frames.get_frame_texture("idle",0)
	var spriteScale = 1.1 * Vector2(
		collisionWidth / spriteTexture.get_width(), 
		collisionWidth / spriteTexture.get_height())
	
	towerAnim.set_scale(spriteScale)

