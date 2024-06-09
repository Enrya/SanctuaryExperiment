extends CharacterBody2D


@export var SPEED = 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var block : CharacterBody2D

func _ready():
	block = $Block
	if block:
		print("Block2D instance found and assigned")
	else:
		print("Block2D instance not found")
	
func _physics_process(delta):
	# Add the gravity if the space bar is pressed
	if not is_on_floor():
		if Input.is_action_just_pressed("drop"):
			velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	#Rotate if pressing E
	if not is_on_floor():
		if Input.is_action_just_pressed("rotate"):
			rotation_degrees += 90

	move_and_slide()
	
