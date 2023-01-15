extends Area2D

export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

export var hand_rotate_speed = .1

func _ready():
	screen_size = get_viewport_rect().size
	add_to_group("player")

func _process(delta):
	$Hand.rotate(hand_rotate_speed)
	
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
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func _on_Excalibur_area_entered(area):
	#if !area.is_in_group("pickup"):
		#return
		
	var gPos = area.global_position
	var gRot = area.global_rotation
	var attachment = area.CreateAttachment(gPos, gRot, $Hand)
