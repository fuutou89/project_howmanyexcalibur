extends Area2D

var attachment_id = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("pickup")
	$CollisionShape2D.disabled = true
	$ReadyTimer.start()
	
	
func InitPickup(pickup_config):
	attachment_id = pickup_config.attachment_id
	pass
	
func CreateAttachment(gpos, grot, attachParent):
	remove_from_group("pickup")
	yield(get_tree(), "idle_frame")
	var attachment_config = ConfigMgr.GetAttachmentConfig(attachment_id)
	var attachment = load("res://" + attachment_config.res_path).instance()
	attachParent.add_child(attachment)
	attachment.set_global_position(gpos)
	attachment.set_global_rotation(grot)
	attachment.InitAttachmentConfig(attachment_config)	
	queue_free()

func _on_ReadyTimer_timeout():
	$CollisionShape2D.disabled = false
	pass
	
func ReleasePickup():
	queue_free()
