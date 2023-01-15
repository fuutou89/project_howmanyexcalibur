extends KinematicBody2D

export var speed = 100 # How fast the player will move (pixels/sec).

export(PackedScene) var pickup_scene

func _ready():
	add_to_group("enemy")

func _process(delta):
	var playerPosition = get_parent().get_node("Player").position
	var linearVelocity = (playerPosition - position).normalized() * speed
	move_and_slide(linearVelocity)

func TakeDamage(damage):
	remove_from_group("enemy")
	$DyingTimer.start()


func _on_DyingTimer_timeout():
	var pickup = pickup_scene.instance()
	
	get_parent().add_child(pickup)
	pickup.set_global_position(global_position)
	
	queue_free()
	pass # Replace with function body.
