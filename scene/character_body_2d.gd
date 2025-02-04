extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

@export var speed := 100  # Reduce speed for better control
@export var acceleration := 500
@export var friction := 400
@export var jump_force := -200
@export var gravity := 2000

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

	
	move_and_slide()
	
func jump():
	if not sprite.is_playing():
		sprite.play("jump")
		
func _input(event):
	velocity.y = jump_force
	if event.is_action_pressed("jump") && Input.is_key_pressed(KEY_SPACE):
		jump()
		
