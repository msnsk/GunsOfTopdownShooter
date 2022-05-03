extends RayCast2D

onready var line = $Line2D
onready var particle = $Particles2D
onready var tween = $Tween


func _ready():
	particle.emitting = false
	tween.interpolate_property(line, "width", 0, 10.0, 0.5)
	tween.start()


func _physics_process(delta):
	if is_colliding():
		line.set_point_position(1, to_local(get_collision_point()))
		
		if get_collider().is_in_group("Obstacles"):
			var obstacle = get_collider()
			obstacle.irradiated_time += delta
			if obstacle.irradiated_time > obstacle.max_irradiation: 
				obstacle.queue_free()
	else:
		line.set_point_position(1, cast_to)
	
	particle.position = line.points[1]
	particle.emitting = true
	
	if Input.is_action_just_released("fire"):
		stop_laser()


func stop_laser():
	tween.interpolate_property(line, "width", 10.0, 0, 0.5)
	tween.start()
	yield(tween, "tween_completed")
	queue_free()
