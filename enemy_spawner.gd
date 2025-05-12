extends Node3D

@onready var spawn_timer = $Timer
const ENEMY = preload("res://enemy.tscn")

func _on_timer_timeout() -> void:
	var newEnemy = ENEMY.instantiate()
	get_parent().add_child(newEnemy)
	
	var random_offset = Vector3(
		randf_range(-5, 5),
		0,
		randf_range(-5, 5)
	)
	newEnemy.global_position = global_position + random_offset
