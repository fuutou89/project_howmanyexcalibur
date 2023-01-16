extends Node2D

var acceleration = 0.1
var decceleration = 0.5
var rotate_dir = 1
var max_rotate_speed = 0.05
var rotate_speed = 0

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	var target_speed = max_rotate_speed * rotate_dir
	var target_rot_dir = target_speed * rotate_speed
	var acc_dir = abs(target_speed) > abs(rotate_speed)
	
	var target_acceleration = 0
	
	if acc_dir:
		if target_rot_dir > 0:
			target_acceleration = acceleration
		else:
			target_acceleration = decceleration
	else:
		target_acceleration = decceleration
	
	rotate_speed = lerp(rotate_speed, target_speed, target_acceleration * delta)
	
	set_physics_process(not is_equal_approx(rotate_speed, target_speed))
	pass

func _process(delta):
	rotate(rotate_speed)
	
func SwitchHand():
	rotate_dir *= -1
	set_physics_process(true)
	
func SetMaxSpeed(new_max_speed):
	if new_max_speed < 0.05:
		max_rotate_speed = 0.05
	if new_max_speed >= 0.05:
		max_rotate_speed = new_max_speed
	set_physics_process(true)	

func SetHandAcceleration(new_acceleration):
	acceleration = new_acceleration
	set_physics_process(true)

func SetHandDecceleration(new_decceleration):
	decceleration = new_decceleration
	set_physics_process(true)
	
func ResetHand():
	acceleration = 0.5
	decceleration = 1
	rotate_dir = 1
	max_rotate_speed = 0.1
	rotate_speed = 0
