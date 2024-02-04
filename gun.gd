extends Area2D

@onready var shooting_point: Marker2D = %ShootingPoint


func _physics_process(delta: float) -> void:
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range[0]
		look_at(target_enemy.global_position)
		
func shoot() -> void:
	const BULLET = preload("res://bullet.tscn")
	var bullet = BULLET.instantiate()
	
	bullet.global_position = shooting_point.global_position
	bullet.global_rotation = shooting_point.global_rotation
	shooting_point.add_child(bullet)


func _on_timer_timeout() -> void:
	shoot()
