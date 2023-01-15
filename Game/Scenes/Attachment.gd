extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("attachments")
	pass # Replace with function body.


func _on_Attachment_area_entered(area):	
	#if !area.is_in_group("pickup"):
		#return
	
	var gPos = area.global_position
	var gRot = area.global_rotation
	var attachment = area.CreateAttachment(gPos, gRot, get_parent())

func _on_ReadyTimer_timeout():
	$CollisionShape2D.disabled = false

func _on_Attachment_body_entered(body):	
	#if !body.is_in_group("enemy"):
		#return
		
	body.TakeDamage(1000)
