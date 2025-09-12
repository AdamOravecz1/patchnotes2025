extends CharacterBody2D

var direction := Vector2.ZERO
var speed := 200
var acceleration := 700
var friction := 900

var gravity := 600
var faster_fall := false
var gravity_multiplier := 1
var terminal_velocity := 500

var charging_jump := false
var charge_time := 0.0
var max_charge := 2.0   # seconds
var min_jump_force := -200.0
var max_jump_force := -425.0

var jump := false
var jump_strength := 300

func _process(delta: float) -> void:
	animate()
	get_input(delta)
	apply_movement(delta)
	apply_gravity(delta)
	move_and_slide()
	
func apply_gravity(delta):
	velocity.y += gravity * delta
	velocity.y = velocity.y / 2 if faster_fall and velocity.y < 0 else velocity.y
	velocity.y = velocity.y * gravity_multiplier
	velocity.y = min(velocity.y, terminal_velocity)
	
func apply_movement(delta):
	# left/right movement 
	if direction.x:
		velocity.x = move_toward(velocity.x, direction.x * speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)

	# Coyote time (keep this if you want the buffer mechanic)
	if is_on_floor() and not is_on_floor() and velocity.y >= 0:
		$Timers/Coyote.start()

func get_input(delta):
	# horizontal movement
	if not charging_jump:
		direction.x = Input.get_axis("left", "right")
	
	# Start charging when jump is pressed on the ground
	if Input.is_action_just_pressed("jump") and direction == Vector2.ZERO and is_on_floor():
		charging_jump = true
		charge_time = 0.0
		$AnimatedSprite2D.play("duck")
		$Legs.visible = false
	
	# If charging, increment the charge time
	if charging_jump and Input.is_action_pressed("jump"):
		charge_time += delta
		charge_time = min(charge_time, max_charge)  # clamp to max_charge
	
	# Release jump -> perform charged jump
	if charging_jump and Input.is_action_just_released("jump"):
		charging_jump = false
		
		# Calculate jump force based on charge ratio
		var t = charge_time / max_charge
		var jump_force = lerp(min_jump_force, max_jump_force, t)
		
		velocity.y = jump_force
		jump = true
		faster_fall = false
		
func animate():
	if not is_on_floor():
		$AnimatedSprite2D.play("jump")
		$Legs.visible = false
	elif not charging_jump:
		$Legs.visible = true
		if velocity.x == 0:
			$AnimatedSprite2D.play("default")
			$Legs.pause()
		else:
			$AnimatedSprite2D.play("move")
			$Legs.play("walk")
	if direction.x == -1:
		$AnimatedSprite2D.flip_h = true
		$Legs.flip_h = true
	elif direction.x == 1:
		$AnimatedSprite2D.flip_h = false
		$Legs.flip_h = false
