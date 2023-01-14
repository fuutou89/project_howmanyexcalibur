extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _on_Excalibur_body_entered(body):	
	if !body.is_in_group("enemy"):
		return
	
	body.TakeDamage(1000)
