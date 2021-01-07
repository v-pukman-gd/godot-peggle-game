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

var ball_vel = Vector2()

func _ready():
	#Engine.time_scale = 0.1
	clear_timer.connect("timeout", self, "on_clear_timeout")
	update_score()
	pass 
	
func _input(event):
	if (event.is_action_pressed("spawn")):
		print(event.as_text())
		spawn_ball(event.position)
	#elif (event is InputEventMouseMotion):
	#	update()
		
func  spawn_ball(pos):
	#if not can_shoot: return
	
	print("spawn ball", pos)
	can_shoot = false
	collected_pegs_score = 0
	
	var ball = ball_scn.instance()
	ball.position = cannon.shoot_position()
	
	var y = sin(cannon.rotation) * IMPULSE
	var x = cos(cannon.rotation) * IMPULSE		
	
	ball_vel = Vector2(x,y)
	print("Vector2(x,y)", Vector2(x,y))
	ball.apply_central_impulse(Vector2(x,y))
	
	add_child(ball)
	balls.append(ball)

func _process(delta):
	for b in balls:
		print("ball.linear_velocity()", b.linear_velocity)
		if b.hit_bottom:
			b.queue_free()
			balls.erase(b)
			clear_timer.start()
			
	update()
			
func _draw():
	var y = sin(cannon.rotation)
	var x = cos(cannon.rotation)
	
	var dir = Vector2(x,y).normalized()
	
	print("dir:", dir)
	
	var velocity = dir * IMPULSE
	var start_point = cannon.shoot_position()
	var g = 98
	
	var step = Vector2(start_point.x, start_point.y)
	var gran = 130.0
	var arr = []
	#arr.append(Vector2(step.x, step.y))
	for i in range(int(gran)):
		#velocity.y += g
		#step.x += velocity.x / gran
		#step.y += velocity.y / gran
		#arr.append(Vector2(step.x, step.y))
		print(i)
		var t = float(i)/float(gran)
		var xx = start_point.x + velocity.x*t
		var yy = start_point.y + velocity.y*t + (g*3.0*t*t)/2.0
		
		arr.append(Vector2(xx, yy))
		
	for p in arr:
		draw_circle(p, 1, Color.greenyellow)
		#draw_rect(Rect2(p, Vector2(5,5)), Color.greenyellow)
	#draw_multiline(PoolVector2Array(arr), Color.greenyellow)
		
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
