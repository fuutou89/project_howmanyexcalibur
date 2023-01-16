extends Area2D

signal get_killed

export var speed = 400 # How fast the player will move (pixels/sec).
export var max_hit_point = 100
var hit_point = max_hit_point


onready var animationplayer = $AnimationPlayer
onready var sprite = $Sprite


#var screen_size # Size of the game window.
func _ready():
	#screen_size = get_viewport_rect().size
	add_to_group("player")	

func _process(delta):	
	var childCount = $Hand.get_child_count()
	var new_zoom = clamp(childCount / 20, 1, 3)
	print(childCount)
	print("HP:", hit_point)
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
	
func PickAttachment(attachment_config):
	$Hand.SetHandAcceleration($Hand.acceleration + attachment_config.acceleration)
	$Hand.SetHandDecceleration($Hand.decceleration + attachment_config.decceleration)
	$Hand.SetMaxSpeed($Hand.max_rotate_speed + attachment_config.max_speed)
	speed += attachment_config.player_speed
	max_hit_point += attachment_config.player_hp
	hit_point += attachment_config.player_hp


func _on_Player_body_entered(body):
	if !body.is_in_group("enemy"):
		return
	
	body.ContactPlayer(true)

func _on_Player_body_exited(body):
	if !body.is_in_group("enemy"):
		return
	
	body.ContactPlayer(false)
	
func TakeDamage(damage):
	hit_point -= damage
	
	if hit_point <= 0:
		emit_signal("get_killed")
		
func RespawnPlayer(pos):
	position = pos
	speed = 400
	max_hit_point = 100
	hit_point = max_hit_point
	$Hand.ResetHand()


