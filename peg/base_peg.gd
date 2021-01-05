extends StaticBody2D

enum Type {BLUE, RED, PURPLE}
export(Type) var type = Type.BLUE
export(int) var points = 10

onready var sprite = $Sprite
onready var game = get_node("/root/Game")
onready var score_label = $ScoreLabel
onready var score_timer = $ScoreTimer

var collected = false

func _ready():
	pass

func hit_by_ball():
	if collected: return
	
	sprite.modulate = Color(1.5, 1.5, 1.5, 1 )
	game.on_peg_collected(self)
	collected = true
	score_label.text = str(points)
	score_timer.start()
	
func _on_score_timeout():
	score_label.text = ""
