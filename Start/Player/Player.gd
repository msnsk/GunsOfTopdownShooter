extends KinematicBody2D


var gun = 0
# 0: hand
# 1: shot
# 2: machine
# 3: lazer
var speed = 200
var velocity = Vector2()


onready var muzzle = $Muzzle


func _ready():
	rotation_degrees = 270
	

func _physics_process(delta):
	move()
	switch_gun()
	fire()
	

func move():
	look_at(get_global_mouse_position())
	velocity = Vector2()
	if Input.is_action_pressed("down"):
		velocity = Vector2(-speed, 0).rotated(rotation)
	if Input.is_action_pressed("up"):
		velocity = Vector2(speed, 0).rotated(rotation)
	velocity = move_and_slide(velocity)


func switch_gun():
	if Input.is_action_just_pressed("switch"):
		if gun < 3:
			gun += 1
		else:
			gun = 0
		print("Switched to ", gun)


func fire():
	pass
