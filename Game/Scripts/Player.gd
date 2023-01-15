extends Area2D

export var speed = 400 # How fast the player will move (pixels/sec).


onready var animationplayer = $AnimationPlayer
onready var sprite = $Sprite


#var screen_size # Size of the game window.
func _ready():
	#screen_size = get_viewport_rect().size
	add_to_group("player")	

func _process(delta):	
	var childCount = $Hand.get_child_count()
	var new_zoom = clamp(childCount / 10.0, 1, 3)
	$Camera2D.ZoomCam(new_zoom)
	
	if Input.is_action_just_released("switch_hand"):
		$Hand.SwitchHand()
	
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
		
	if velocity != Vector2.ZERO:#移动动画播放
		 animationplayer.play("RUN",-1, 1, false)
		
	if velocity.x < 0:#左右翻转
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false
		

	position += velocity * delta
	#position.x = clamp(position.x, 0, screen_size.x)
	#position.y = clamp(position.y, 0, screen_size.y)


func _on_Excalibur_area_entered(area):
	if !area.is_in_group("pickup"):
		return
		
	var gPos = area.global_position
	var gRot = area.global_rotation
	var attachment = area.CreateAttachment(gPos, gRot, $Hand)
	
func PickAttachment(acceleration, decceleration, max_speed):
	$Hand.SetHandAcceleration($Hand.acceleration + max_speed)
	$Hand.SetHandDecceleration($Hand.decceleration + max_speed)
	$Hand.SetMaxSpeed($Hand.max_rotate_speed + max_speed)
