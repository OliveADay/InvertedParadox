extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -300.0	

var gravM = true
@export var controler = Control

@export var jumpTrue = true

var walkCyc = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if $GravJumpActiv.has_overlapping_bodies():
		jumpTrue = false
		var bodies = $GravJumpActiv.get_overlapping_bodies()
		bodies[0].queue_free()
		controler.visible = true
		$pickupAud.playing = true
	if $SpikeSense.has_overlapping_bodies():
		$deadAud.playing = true
		get_tree().reload_current_scene()
	
	if not is_on_floor():	
		if gravM:
			velocity.y += gravity * delta
			$CPUParticles2D.position.y = 8
		else:
			velocity.y -= gravity * delta
			$CPUParticles2D.position.y = -8
		
			
	if Input.is_action_just_pressed("shift_up") and not jumpTrue:
		if gravM:
			$shiftAud.playing = true
		gravM = false
		$Sprite2D.frame = 1
		$Sprite2D.scale.y = -1
		velocity.y  = 0
	if Input.is_action_just_pressed("shift_down") and not jumpTrue:
		if not gravM:
			$shiftAud.playing = true
		gravM = true
		$Sprite2D.scale.y = 1
		$Sprite2D.frame = 0
		velocity.y = 0
	
	# Handle jump.
	if Input.is_action_just_pressed("shift_up") and is_on_floor():
			if jumpTrue:
				$JumpAud.playing = true
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
	if $GroundCheck.has_overlapping_bodies() and direction != 0:
		if(walkCyc > 0):
			walkCyc -= delta
		else:
			$walkAud.playing = true
			walkCyc = 0.3
		$CPUParticles2D.emitting = true
	else:
		$CPUParticles2D.emitting = false
		walkCyc = 0
		
	move_and_slide()
