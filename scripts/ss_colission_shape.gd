extends CollisionShape2D

@onready var ssPuddleAnim = $ssPuddleAnim

var animName;

# Called when the node enters the scene tree for the first time.
func _ready():
	set_anim_scale()
	ssPuddleAnim.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func play_anim(_animName):
	ssPuddleAnim.show()
	ssPuddleAnim.play(_animName)
	animName = _animName
	

func set_anim_scale():
	# Set the sprite size to match the colissionbox size
	var collisionWidth = shape.get_radius() * 2
	var spriteTexture = ssPuddleAnim.sprite_frames.get_frame_texture("spread_out",0)
	var spriteScale = 1.1 * Vector2(
		collisionWidth / spriteTexture.get_width(), 
		collisionWidth / spriteTexture.get_height())
	
	ssPuddleAnim.set_scale(spriteScale)


func _on_ss_puddle_anim_animation_finished():
	if animName == "absorb":
		ssPuddleAnim.hide()
	pass # Replace with function body.
