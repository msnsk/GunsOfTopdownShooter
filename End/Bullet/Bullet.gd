# Bullet.gd
extends Area2D

var speed = 1500
var direction = Vector2.ZERO

func _physics_process(delta):
	direction.x = cos(global_rotation)
	direction.y = sin(global_rotation)
	translate(direction * speed * delta)
	
func _on_Bullet_body_entered(body):
	if body.is_in_group("Obstacles"):
		body.queue_free()
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
