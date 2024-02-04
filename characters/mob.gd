extends CharacterBody2D

@onready var player: Player = get_node("/root/Game/Player")
@onready var slime: Node2D = %Slime

@export var max_health: int = 5
@onready var health: int = max_health

func _ready() -> void:
	slime.play_walk()

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300.0
	move_and_slide()

func take_damage(damage: int) -> void:
	if damage < 0:
		push_error("tried to take negative damage", damage)
		return
	
	health -= damage
	slime.play_hurt()
	
	if health <= 0:
		die()

func die() -> void:
	const SMOKE_EXPLOSION = preload("res://smoke_explosion/smoke_explosion.tscn")
	var smoke = SMOKE_EXPLOSION.instantiate()
	get_parent().add_child(smoke)
	smoke.global_position = global_position
	queue_free()
	
