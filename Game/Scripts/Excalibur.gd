extends Area2D

onready var hit_sound = preload("res://Scenes/Audio_HIT.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _on_Excalibur_body_entered(body):	
	if !body.is_in_group("enemy"):
		var audio_hit = hit_sound.instance()
		get_tree().get_root().call_deferred("add_child", audio_hit)
		return
	
	body.TakeDamage(1000)
