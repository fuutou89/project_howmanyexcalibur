extends KinematicBody2D

var speed = 100
var health_point = 100
var attack_point = 10
var pickup_id = 0

var bGotPlayer = false

export(PackedScene) var pickup_scene

func _ready():
	add_to_group("enemy")

func _process(delta):
	var playerPosition = get_parent().get_node("Player").position
	var linearVelocity = (playerPosition - position).normalized() * speed
	move_and_slide(linearVelocity)
	
	if bGotPlayer and $AttackTimer.is_stopped():
		$AttackTimer.start()
	elif !bGotPlayer and !$AttackTimer.is_stopped():
		$AttackTimer.stop()
	
func InitEnemy(enemyConfig):
	speed = enemyConfig.speed
	health_point = enemyConfig.health_point
	attack_point = enemyConfig.attack_point
	pickup_id = enemyConfig.pickup_id

func TakeDamage(damage):
	health_point -= damage
	if health_point <= 0:
		remove_from_group("enemy")
		$DyingTimer.start()

func _on_DyingTimer_timeout():
	var pickup_config = ConfigMgr.GetPickupConfig(pickup_id)
	var pickup = load("res://" + pickup_config.res_path).instance()
	pickup.InitPickup(pickup_config)
	get_parent().add_child(pickup)
	pickup.set_global_position(global_position)
	
	queue_free()
	pass # Replace with function body.

func ContactPlayer(bContact):
	bGotPlayer = bContact

func ReleaseEnemy():
	queue_free()

func _on_AttackTimer_timeout():
	get_tree().call_group("player", "TakeDamage", attack_point)
	pass # Replace with function body.
