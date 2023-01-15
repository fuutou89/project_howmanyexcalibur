extends Node

onready var enemy_cfg = preload("res://datas/Enemy.csv")
onready var pickup_cfg = preload("res://datas/Pickup.csv")
onready var attachment_cfg = preload("res://datas/ExcaliburAttachment.csv")

func GetEnemyConfig(enemy_id):
	for enemy in enemy_cfg.records:
		if enemy.id == enemy_id:
			return enemy
			
func GetPickupConfig(pickup_id):
	for pickup in pickup_cfg.records:
		if pickup.id == pickup_id:
			return pickup

func GetAttachmentConfig(attachment_id):
	for attachment in attachment_cfg.records:
		if attachment.id == attachment_id:
			return attachment
