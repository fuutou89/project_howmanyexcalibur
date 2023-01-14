extends Area2D

var bAttached = false

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("attachments")
	pass # Replace with function body.


func _on_Attachment_area_entered(area):
	if !area.is_in_group("attachments"):
		return
	
	if area.bAttached:
		return
	
	var attchement_gpos = area.global_position
	
	area.bAttached = true
	area.get_parent().remove_child(area)
	get_parent().add_child(area)
	
	area.set_global_position(attchement_gpos)


func _on_ReadyTimer_timeout():
	$CollisionShape2D.disabled = false

func _on_Attachment_body_entered(body):
	if !bAttached:
		return
	
	if !body.is_in_group("enemy"):
		return
		
	body.TakeDamage(1000)
