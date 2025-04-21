extends CharacterBody3D

@onready var nav_agent =$NavigationAgent3D
@onready var process = $"../CanvasLayer/ProgressBar"
@onready var timer = $"../Timer"
var SPEED = 3.0 
var health = 10
func _physics_process(delta):
	var current_location = global_transform.origin
	var next_location =  nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED 
	
	nav_agent.set_velocity(new_velocity)

func update_target_location(target_location):
	nav_agent.target_position = target_location

func _on_navigation_agent_3d_target_reached():
	pass


func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	velocity = velocity.move_toward(safe_velocity, 0.25)
	move_and_slide()


func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		timer.start()


func _on_timer_timeout():
	process.value -= 10


func take_damage(damage: int):
	health -= damage
	print("Enemy HP:", health)
	if health <= 0:
		queue_free()
