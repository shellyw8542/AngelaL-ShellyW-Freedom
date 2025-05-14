extends Node3D

@onready var spawn_timer = $Timer
const ENEMY = preload("res://enemy.tscn")

func _on_timer_timeout() -> void:
	var new_enemy = ENEMY.instantiate()
	get_parent().add_child(new_enemy)

	# Offset spawn position
	var random_offset = Vector3(
		randf_range(-5, 5),
		0,
		randf_range(-5, 5)
	)
	new_enemy.global_position = global_position + random_offset

	# Find the player in the scene and assign it
	var player = get_tree().get_nodes_in_group("player")[0]  # assumes only one player
	new_enemy.set_target(player)
