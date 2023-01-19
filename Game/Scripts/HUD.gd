extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var time = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	time += 1
	$time.text = str(time) + " s"
	

