extends CharacterBody3D
@onready var health_bar = get_node("/root/World/CanvasLayer/HealthBar")

@onready var hitbox_area = $Area3D
@onready var nav_agent =$NavigationAgent3D
@onready var process = $"../CanvasLayer/ProgressBar"
@onready var timer = $"../Timer"
var SPEED = 3.0 
var health = 10
var player_inside = null
func set_target(player_ref):
	if player_ref:
		update_target_location(player_ref.global_position)
		# Store reference so you can track player movement or damage them later
	if player_inside:
		update_target_location(player_inside.global_position)
		player_inside = player_ref
		
func _physics_process(delta):
	var current_location = global_transform.origin
	var next_location =  nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED 
	
	nav_agent.set_velocity(new_velocity)
	if player_inside:
		update_target_location(player_inside.global_position)
func update_target_location(target_location):
	nav_agent.target_position = target_location

func _on_navigation_agent_3d_target_reached():
	pass


func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	velocity = velocity.move_toward(safe_velocity, 0.25)
	move_and_slide()


func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		print("Instant damage test")
		if body.has_method("take_damage"):
			body.take_damage(2)

func _on_timer_timeout():
	if player_inside and player_inside.has_method("take_damage"):
		print("Enemy attacking player...")
		player_inside.take_damage(2)
		process.value -= 20

func _on_area_3d_body_exited(body):
	if body == player_inside:
		player_inside = null
		timer.stop()
	# Try to find the player again
	for other_body in hitbox_area.get_overlapping_bodies():
		if other_body.is_in_group("player"):
			if other_body.has_method("take_damage"):
				other_body.take_damage(2)
				
func take_damage(damage: int):
	health -= damage
	print("Enemy HP:", health)
	if health <= 0:
		ScoreManager.add_score(1)
		queue_free()  # <- makes it so that the enemy is gone from the game
