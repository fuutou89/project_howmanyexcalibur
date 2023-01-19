extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hp_value setget hit_point_changed

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("attachments")
	pass # Replace with function body.
	
func hit_point_changed(value):
	text = "HP=" + str(value)

#func _process(delta):
#	pass
