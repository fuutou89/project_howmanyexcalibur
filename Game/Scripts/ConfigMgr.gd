extends Node

onready var enemy_cfg = preload("res://datas/Enemy.csv")
onready var pickup_cfg = preload("res://datas/Pickup.csv")
onready var attachment_cfg = preload("res://datas/ExcaliburAttachment.csv")
onready var enemy_wave_cfg = preload("res://datas/EnemyWave.csv")
onready var game_time_table_cfg = preload("res://datas/GameTimeTable.csv")

func GetEnemyConfig(enemy_id):
	for enemy in enemy_cfg.records:
		if enemy.id == enemy_id:
			return enemy

func GetRandEnemyConfigInGroup(enemy_group_id):
	var enemy_configs = []
	
	for enemy in enemy_cfg.records:
		if enemy.group_id == enemy_group_id:
			enemy_configs.append(enemy)
	
	enemy_configs.shuffle()
	return enemy_configs[0]
	
			
func GetPickupConfig(pickup_id):
	for pickup in pickup_cfg.records:
		if pickup.id == pickup_id:
			return pickup

func GetAttachmentConfig(attachment_id):
	for attachment in attachment_cfg.records:
		if attachment.id == attachment_id:
			return attachment

func GetEnemySpawnInterval(game_time):
	for game_time_table in game_time_table_cfg.records:
		if game_time >= game_time_table.time_range_min and game_time < game_time_table.time_range_max:
			return game_time_table.enemy_spawn_interval

func GetSpawnEnemyConfig(game_time):
	var enemy_groups = []
	
	var totalWight = 0
	for enemy_wave in enemy_wave_cfg.records:
		if game_time >= enemy_wave.time_range_min and game_time < enemy_wave.time_range_max:
			enemy_groups.append({group_id = enemy_wave.enemy_group_id, weight = enemy_wave.weight})
			totalWight += enemy_wave.weight
	
	var randWeight = randi() % totalWight
	var curWeight = 0
	for enemy_group in enemy_groups:
		curWeight += enemy_group.weight
		if curWeight >= randWeight:
			return GetRandEnemyConfigInGroup(enemy_group.group_id)
