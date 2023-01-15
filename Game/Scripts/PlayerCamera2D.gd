extends Camera2D

const ZOOM_RATE: float = 0.5
var _target_zoom: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	zoom = lerp(zoom, _target_zoom * Vector2.ONE, ZOOM_RATE * delta)
	set_physics_process(not is_equal_approx(zoom.x, _target_zoom))

func ZoomCam(new_zoom):
	if _target_zoom != new_zoom:
		_target_zoom = new_zoom
		set_physics_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
