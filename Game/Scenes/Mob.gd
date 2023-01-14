extends KinematicBody2D

export var speed = 100 # How fast the player will move (pixels/sec).

export(PackedScene) var attachment_scene

func _ready():
	add_to_group("enemy")

func _process(delta):
	var playerPosition = get_parent().get_node("Player").position
	var linearVelocity = (playerPosition - position).normalized() * speed
	move_and_slide(linearVelocity)

func TakeDamage(damage):
	var attachment = attachment_scene.instance()
	
	get_parent().add_child(attachment)
	attachment.set_global_position(global_position)
	
	queue_free()
	pass
