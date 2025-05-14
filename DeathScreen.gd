extends CanvasLayer

func _ready():
	var death_screen = get_node_or_null("/root/World/DeathScreen")
	death_screen.visible = false
func _on_button_pressed():
	get_tree().reload_current_scene()
