extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.RespawnPlayer($PlayerStart.position)	

func _on_MobTimer_timeout():
	# Create a new instance of the Mob scene.
	var enemyConfig = ConfigMgr.GetEnemyConfig(1)
	var mob = load("res://" + enemyConfig.res_path).instance()
	mob.InitEnemy(enemyConfig)
	var mob_spawn_location = $Player.position + Vector2(1000, 0).rotated(rand_range(0, 2*PI))
	mob.position = mob_spawn_location #mob_spawn_location.position
	add_child(mob)

func _on_Player_get_killed():
	get_tree().call_group("attachments", "Detach")
	get_tree().call_group("enemy", "ReleaseEnemy")
	get_tree().call_group("pickup", "ReleasePickup")
	$Player.RespawnPlayer($PlayerStart.position)
