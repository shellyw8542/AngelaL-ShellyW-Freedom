extends CanvasLayer

func _ready():
	hide()

func _on_button_pressed():
	get_tree().reload_current_scene()
