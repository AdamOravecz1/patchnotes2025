extends CharacterBody2D

@export var rays = false
@export var down = false

@export var speed: float = 100.0
@export var gravity: float = 600.0
var direction: int = 1  # 1 = right, -1 = left

func _ready() -> void:
	if down:
		$Left.position.y = 0
		$Right.position.y = 0

func _physics_process(delta: float) -> void:
	if $Left.is_colliding() and rays:
		var collider = $Left.get_collider()
		direction = -1
		if $AnimatedSprite2D:
			$AnimatedSprite2D.flip_h = direction < 0
	if $Right.is_colliding() and rays:
		var collider = $Right.get_collider()
		direction = 1
		if $AnimatedSprite2D:
			$AnimatedSprite2D.flip_h = direction < 0
		
		
		
	# apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0  # reset vertical velocity when grounded

	# horizontal movement
	velocity.x = direction * speed

	# move and handle collisions
	move_and_slide()

	# flip on wall
	if is_on_wall():
		direction *= -1
		if $AnimatedSprite2D:
			$AnimatedSprite2D.flip_h = direction < 0
			
