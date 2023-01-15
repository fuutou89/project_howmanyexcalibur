extends Area2D

var max_speed = 0
var acceleration = 0
var decceleration = 0
var attack_point = 0
var player_hp = 0
var player_speed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("attachments")
	pass # Replace with function body.

func InitAttachmentConfig(attachment_config):
	acceleration = attachment_config.acceleration
	decceleration = attachment_config.decceleration
	max_speed = attachment_config.max_speed
	player_hp = attachment_config.player_hp
	player_speed = attachment_config.player_speed
	attack_point = attachment_config.attack_point
	get_tree().call_group("player", "PickAttachment", attachment_config)	

func _on_Attachment_area_entered(area):	
	if !area.is_in_group("pickup"):
		return
	
	var gPos = area.global_position
	var gRot = area.global_rotation
	var attachment = area.CreateAttachment(gPos, gRot, get_parent())

func _on_ReadyTimer_timeout():
	$CollisionShape2D.disabled = false

func _on_Attachment_body_entered(body):	
	if !body.is_in_group("enemy"):
		return
		
	body.TakeDamage(attack_point)
	
func Detach():
	queue_free()
