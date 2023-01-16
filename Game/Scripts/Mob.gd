extends KinematicBody2D

var speed = 100
var health_point = 100
var attack_point = 10
var pickup_id = 0
var attack_cooldown = 0.1

export(PackedScene) var pickup_scene
onready var hit_sound = preload("res://Scenes/Audio_HIT.tscn")

func _ready():
	add_to_group("enemy")

func _process(delta):
	var playerPosition = get_parent().get_node("Player").position
	var linearVelocity = (playerPosition - position).normalized() * speed
	move_and_slide(linearVelocity)
	
func InitEnemy(enemyConfig):
	speed = enemyConfig.speed
	health_point = enemyConfig.health_point
	attack_point = enemyConfig.attack_point
	pickup_id = enemyConfig.pickup_id
	attack_cooldown = enemyConfig.attack_cooldown

func TakeDamage(damage):
	var audio_hit = hit_sound.instance()
	get_tree().get_root().add_child(audio_hit)
	audio_hit.position = position
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
	if bContact:
		if $AttackTimer.is_stopped():
			$AttackTimer.wait_time = attack_cooldown
			$AttackTimer.start()
	else:
		if !$AttackTimer.is_stopped():
			$AttackTimer.stop()	

func ReleaseEnemy():
	queue_free()

func _on_AttackTimer_timeout():
	get_tree().call_group("player", "TakeDamage", attack_point)
	pass # Replace with function body.
