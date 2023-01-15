extends Area2D

export var speed = 400 # How fast the player will move (pixels/sec).
#var screen_size # Size of the game window.

export var hand_rotate_speed = .1
const ZOOM_RATE: float = 0.5
var _target_zoom: float = 1.0

func _ready():
	#screen_size = get_viewport_rect().size
	add_to_group("player")
	
func _physics_process(delta):
	$Camera2D.zoom = lerp($Camera2D.zoom, _target_zoom * Vector2.ONE, ZOOM_RATE * delta)
	set_physics_process(not is_equal_approx($Camera2D.zoom.x, _target_zoom))

func _process(delta):
	$Hand.rotate(hand_rotate_speed)
	
	var childCount = $Hand.get_child_count()
	var new_zoom = clamp(childCount / 10.0, 1, 3)
	if _target_zoom != new_zoom:
		_target_zoom = new_zoom
		set_physics_process(true)
	
	if Input.is_action_just_released("switch_hand"):
		hand_rotate_speed *= -1
	
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	position += velocity * delta
	#position.x = clamp(position.x, 0, screen_size.x)
	#position.y = clamp(position.y, 0, screen_size.y)


func _on_Excalibur_area_entered(area):
	if !area.is_in_group("pickup"):
		return
		
	var gPos = area.global_position
	var gRot = area.global_rotation
	var attachment = area.CreateAttachment(gPos, gRot, $Hand)
