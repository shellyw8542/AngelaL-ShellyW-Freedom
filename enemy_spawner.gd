extends Node3D

@onready var spawn_timer = $Timer
const ENEMY = preload("res://enemy.tscn")

func _on_timer_timeout() -> void:
	var new_enemy = ENEMY.instantiate()
	get_parent().add_child(new_enemy)

	var random_offset = Vector3(
		randf_range(-5, 5),
		0,
		randf_range(-5, 5)
	)
	new_enemy.global_position = global_position + random_offset

	var player = get_tree().get_nodes_in_group("player")[0]
	new_enemy.call_deferred("set_target", player)
