extends RigidBody2D

var hit_bottom = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ball_body_entered(body):
	print("hit:", body)
	if body.is_in_group("peg"):
		body.hit_by_ball()
	elif body.is_in_group("bottom"):
		self.hit_bottom = true
