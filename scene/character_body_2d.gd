extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

@export var speed := 100  # Reduce speed for better control
@export var acceleration := 500
@export var friction := 700
@export var jump_force := -300
@export var gravity := 500

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get movement input
	var direction = Input.get_axis("move_left", "move_right")

	# Smooth movement
	if direction != 0:
		velocity.x = move_toward(velocity.x, direction * speed, acceleration * delta)
		sprite.play("run")
		sprite.flip_h = (direction < 0)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)
		sprite.play("idle")

	# Jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force

	move_and_slide()
