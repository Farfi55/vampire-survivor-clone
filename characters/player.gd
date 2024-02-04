extends CharacterBody2D
class_name Player

@onready var happy_boo: Node2D = %HappyBoo	


func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600.0;
	move_and_slide()
	
	if velocity != Vector2.ZERO:
		happy_boo.play_walk_animation()
	else:
		happy_boo.play_idle_animation()

