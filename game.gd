extends Node2D


var ball_scn = preload("res://ball.tscn")


func _ready():
	pass 
	
func _input(event):
	if (event.is_action_pressed("spawn")):
		print(event.as_text())
		spawn_ball(event.position)
		
func  spawn_ball(pos):
	print("spawn ball", pos)
	
	var ball = ball_scn.instance()
	ball.position = pos
	add_child(ball)
