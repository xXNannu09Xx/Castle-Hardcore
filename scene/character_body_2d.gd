extends TileMap  # Attach this script to TileMap2

@export var fall_distance: int = 50  # Distance before falling
@export var fall_speed: float = 300  # Speed of falling

var falling = false  # Track if TileMap is falling

func _ready():
	set_physics_process(true)  # Enable physics updates

func _physics_process(delta):
	if falling:
		position.y += fall_speed * delta  # Move TileMap down
		return

	var player_node = get_node("../CharacterBody2D")  # Change name if needed
	if player_node:
		var distance_x = abs(player_node.global_position.x - global_position.x)
		var player_below = player_node.global_position.y > (global_position.y - fall_distance)

		if player_below and distance_x < 50:  # Player is beneath TileMap
			falling = true
