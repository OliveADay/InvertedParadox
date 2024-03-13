extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -300.0	

var gravM = true
@export var controler = Control

@export var jumpTrue = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if $GravJumpActiv.has_overlapping_bodies():
		jumpTrue = false
		var bodies = $GravJumpActiv.get_overlapping_bodies()
		bodies[0].queue_free()
		controler.visible = true	
		#$Control/Timer.start(2)	
	if $SpikeSense.has_overlapping_bodies():
		get_tree().reload_current_scene()
	
	if not is_on_floor():
		
		if gravM:
			velocity.y += gravity * delta
			$CPUParticles2D.position.y = 8
		else:
			velocity.y -= gravity * delta
			$CPUParticles2D.position.y = -8
	if $GroundCheck.has_overlapping_bodies():
		$CPUParticles2D.visible = true
	else:
		$CPUParticles2D.visible = false
		
			
	if Input.is_action_just_pressed("shift_up") and not jumpTrue:
		gravM = false
		$Sprite2D.frame = 1
		$Sprite2D.scale.y = -1
		velocity.y  = 0
	if Input.is_action_just_pressed("shift_down") and not jumpTrue:
		gravM = true
		$Sprite2D.scale.y = 1
		$Sprite2D.frame = 0
		velocity.y = 0
	
	# Handle jump.
	if Input.is_action_just_pressed("shift_up") and is_on_floor():
			velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction == 1:
		$Sprite2D.scale.x = -1
		$CPUParticles2D.position.x = 5
	if direction == -1:
		$Sprite2D.scale.x = 1
		$CPUParticles2D.position.x = -5
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		#$CPUParticles2D.visible = false
		
	move_and_slide()
