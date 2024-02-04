extends CharacterBody2D
class_name Player

@export var max_health: float = 100.0
@onready var health: float = max_health

@export var damage_rate: float = 10.0

@onready var progress_bar: ProgressBar = %ProgressBar

@onready var happy_boo: Node2D = %HappyBoo
@onready var hurt_box: Area2D = %HurtBox

signal health_depleted

func _ready() -> void:
	health = max_health
	progress_bar.max_value = max_health
	progress_bar.value = health

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600.0;
	move_and_slide()
	
	if velocity != Vector2.ZERO:
		happy_boo.play_walk_animation()
	else:
		happy_boo.play_idle_animation()
	
	var overlapping_mobs = hurt_box.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= damage_rate * overlapping_mobs.size() * _delta
		if health <= 0:
			health_depleted.emit()
		progress_bar.value = health
