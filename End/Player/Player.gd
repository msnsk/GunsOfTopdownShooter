extends KinematicBody2D

const bullet_scn = preload("res://Bullet/Bullet.tscn")
const laser_scn = preload("res://Laser/Laser.tscn")

var gun = 0
# 0: hand
# 1: shot
# 2: machine
# 3: lazer
var speed = 200
var velocity = Vector2()
var interval: int = 0

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
	if gun == 0 and Input.is_action_just_pressed("fire"):
		put_bullet()
	if gun == 1 and Input.is_action_just_pressed("fire"):
		for n in 5:
			put_bullet(n)
	if gun == 2 and Input.is_action_pressed("fire"):
		interval += 1
		if interval >= 5:
			interval = 0
			put_bullet()
	if gun == 3 and Input.is_action_just_pressed("fire"):
		load_laser()


func put_bullet(dir_offset = 2):
	var bullet = bullet_scn.instance()
	bullet.global_position = muzzle.global_position
	bullet.rotation_degrees = rotation_degrees + (20 - 10 * dir_offset)
	get_parent().add_child(bullet)
	get_parent().move_child(bullet, 1)


func load_laser():
	var laser = laser_scn.instance()
	laser.position = muzzle.position
	add_child(laser)
	move_child(laser, 0)
