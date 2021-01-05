extends Node2D


var ball_scn = preload("res://ball.tscn")
onready var cannon = $Cannon
onready var clear_timer = $ClearTimer
onready var score_label = $ScoreLabel

const IMPULSE = 500

var can_shoot = true
var balls = []
var collected_pegs = []

var total_score = 0
var collected_pegs_score = 0

func _ready():
	clear_timer.connect("timeout", self, "on_clear_timeout")
	update_score()
	pass 
	
func _input(event):
	if (event.is_action_pressed("spawn")):
		print(event.as_text())
		spawn_ball(event.position)
		
func  spawn_ball(pos):
	if not can_shoot: return
	
	print("spawn ball", pos)
	can_shoot = false
	collected_pegs_score = 0
	
	var ball = ball_scn.instance()
	ball.position = cannon.get_node("Position2D").global_position
	
	var y = sin(cannon.rotation) * IMPULSE
	var x = cos(cannon.rotation) * IMPULSE		
	
	ball.apply_central_impulse(Vector2(x,y))
	add_child(ball)
	balls.append(ball)

func _process(delta):
	for b in balls:
		if b.hit_bottom:
			b.queue_free()
			balls.erase(b)
			clear_timer.start()
			
func on_peg_collected(peg):
	collected_pegs.append(peg)
	collected_pegs_score += peg.points
	
func on_clear_timeout():
	var peg = collected_pegs.pop_front()
	if peg != null:
		peg.queue_free()
	else:
		clear_timer.stop()
		can_shoot = true
		update_score()
	
func update_score():
	total_score += collected_pegs_score
	collected_pegs_score = 0
	score_label.text = str(total_score)
