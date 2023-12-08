extends Camera2D

var speed = 500
var content_width = 1000
var content_height = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	limit_left = 0
	limit_top = 0
	#limit_right = 1100
	#limit_bottom = 1100
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# handle inputs
	if Input.is_action_pressed("MoveCameraDown"):
		position.y += speed * delta
	if Input.is_action_pressed("MoveCameraUp"):
		position.y -= speed * delta
	if Input.is_action_pressed("MoveCameraLeft"):
		position.x -= speed * delta
	if Input.is_action_pressed("MoveCameraRight"):
		position.x += speed * delta
	if Input.is_action_pressed("CameraZoomIn"):
		zoom.x += delta
		zoom.y += delta
	if Input.is_action_pressed("CameraZoomOut"):
		zoom.x -= delta
		zoom.y -= delta

	# zoom to fit the viewport
	fit_camera_to_viewport()


func fit_camera_to_viewport():
	# Get the viewport size
	var viewport_size = get_viewport_rect().size

	# Calculate the aspect ratios of the content and the viewport
	var content_aspect_ratio = content_width / content_height
	var viewport_aspect_ratio = viewport_size.x / viewport_size.y

	# Calculate the zoom level to fit the content into the viewport
	var z = 1.0

	if content_aspect_ratio > viewport_aspect_ratio:
		# Content is wider than the viewport
		z = viewport_size.x / content_width
	else:
		# Content is taller than or equal to the viewport
		z = viewport_size.y / content_height

	# Set the calculated zoom level
	zoom.x = z
	zoom.y = z
