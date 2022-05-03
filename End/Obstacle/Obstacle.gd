extends StaticBody2D


const smoke_scn = preload("res://Obstacle/Smoke.tscn")

var irradiated_time: float = 0.0
var max_irradiation: float = 0.2



func _on_Obstacle_tree_exiting():
	var smoke = smoke_scn.instance()
	get_parent().add_child(smoke)
	smoke.global_position = global_position + Vector2(32, 32)
	
