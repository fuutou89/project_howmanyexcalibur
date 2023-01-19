extends Node

var time_since_game_start = 0
var total_game_time = 600
var b_game_start = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$StartTimer.start()	
	pass
	
func _process(delta):
	if !b_game_start: 
		return
	time_since_game_start += delta
	if time_since_game_start >= total_game_time:
		_on_Player_get_killed()

func _on_MobTimer_timeout():
	# Create a new instance of the Mob scene.
	#var enemyConfig = ConfigMgr.GetEnemyConfig(1)
	var enemy_config = ConfigMgr.GetSpawnEnemyConfig(time_since_game_start)
	var mob = load("res://" + enemy_config.res_path).instance()
	mob.InitEnemy(enemy_config)
	var mob_spawn_location = $Player.position + Vector2(1000, 0).rotated(rand_range(0, 2*PI))
	mob.position = mob_spawn_location #mob_spawn_location.position
	add_child(mob)
	var spawnInternal = ConfigMgr.GetEnemySpawnInterval(time_since_game_start)
	$MobTimer.wait_time = spawnInternal

func _on_Player_get_killed():
	b_game_start = false
	$Music.stop()
	$MobTimer.stop()
	get_tree().call_group("attachments", "Detach")
	get_tree().call_group("enemy", "ReleaseEnemy")
	get_tree().call_group("pickup", "ReleasePickup")
	get_tree().reload_current_scene()
	$StartTimer.start()

func _on_StartTimer_timeout():
	b_game_start = true	
	time_since_game_start = 0
	$Player.RespawnPlayer($PlayerStart.position)
	var spawnInternal = ConfigMgr.GetEnemySpawnInterval(time_since_game_start)
	$MobTimer.wait_time = spawnInternal
	$MobTimer.start()
	$Music.play()	
