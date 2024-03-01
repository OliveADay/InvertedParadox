extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -300.0	

var gravM = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		if gravM:
			velocity.y += gravity * delta
		else:
			velocity.y -= gravity * delta
			
	if Input.is_action_just_pressed("shift_up"):
		gravM = false
		velocity.y  = 0
	if Input.is_action_just_pressed("shift_down"):
		gravM = true
		velocity.y = 0
	
	# Handle jump.
	if Input.is_action_just_pressed("shift_up") and is_on_floor():
			velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction == 1:
		$Sprite2D.scale.x = -1
	if direction == -1:
		$Sprite2D.scale.x = 1
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()