extends Node


export(PackedScene) var mob_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var mobCount = 0

func _on_MobTimer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instance()

	var mob_spawn_location = $Player.position + Vector2(1000, 0).rotated(rand_range(0, 2*PI))
	# Choose a random location on Path2D.
	#var mob_spawn_location = get_node("Player/MobPath/MobSpawnLocation")
	#mob_spawn_location.offset = randi()

	# Set the mob's direction perpendicular to the path direction.
	# var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location #mob_spawn_location.position

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
	
	mobCount += 1
	if mobCount >= 9999:
		$MobTimer.stop()
