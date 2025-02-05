extends TileMap  # Attach this to TileMap2

@export var player: NodePath  # Assign player node in Inspector
@export var fall_distance: int = 50  # Distance to detect player below
@export var fall_speed: float = 300  # Speed of falling

var falling = false  # Track if TileMap2 is falling

func _process(delta):
	if falling:
		global_position.y += fall_speed * delta  # Move entire TileMap down
		return  # Stop checking player position

	var player_node = get_node(player)  # Get the player node reference
	if player_node:
		var distance_x = abs(player_node.global_position.x - global_position.x)
		var player_below = player_node.global_position.y > (global_position.y - fall_distance)

		if player_below and distance_x < 50:  # Player is under TileMap2
			falling = true
