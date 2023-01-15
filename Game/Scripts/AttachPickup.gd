extends Area2D

export(PackedScene) var attachment_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("pickup")
	pass # Replace with function body.
	

func CreateAttachment(gpos, grot, attachParent):
	yield(get_tree(), "idle_frame")
	var attachment = attachment_scene.instance()
	attachParent.add_child(attachment)
	attachment.set_global_position(gpos)
	attachment.set_global_rotation(grot)
	queue_free()

func _on_ReadyTimer_timeout():
	$CollisionShape2D.disabled = false
