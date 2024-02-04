extends Area2D

@export var speed: float = 1000.0
@export var range = 1200.0

var travelled_distance: float = 0

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	var position_change: Vector2 = speed * delta * direction
	position += position_change
	
	travelled_distance += speed * delta
	if travelled_distance >= range:
		queue_free()
		
	


func _on_body_entered(body: Node2D) -> void:
	# destroyes the node on the next frame, so we can still do stuff after this line
	queue_free() 
	
	if body.has_method("take_damage"):
		body.take_damage(1)

