extends CanvasLayer

@onready var score_label = $ScoreLabel

func _process(_delta):
	score_label.text = "Score: " + str(ScoreManager.score)
