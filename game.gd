extends Node2D


var ball_scn = preload("res://ball.tscn")
onready var cannon = $Cannon

const IMPULSE = 500

func _ready():
	pass 
	
func _input(event):
	if (event.is_action_pressed("spawn")):
		print(event.as_text())
		spawn_ball(event.position)
		
func  spawn_ball(pos):
	print("spawn ball", pos)
	
	var ball = ball_scn.instance()
	ball.position = cannon.get_node("Position2D").global_position
	
	var y = sin(cannon.rotation) * IMPULSE
	var x = cos(cannon.rotation) * IMPULSE		
	
	ball.apply_central_impulse(Vector2(x,y))
	add_child(ball)
