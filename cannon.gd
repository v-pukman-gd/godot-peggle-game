extends Node2D

const Y_MIN = 100

func _ready():
	pass

func _input(event):
	if event is InputEventMouseButton:
		print("Mouse click at:", event.position)
		
func _process(delta):
	pass
	
# Variant 1:
func follow_cursor(cursor_pos):
	var x = cursor_pos.x - self.position.x
	var y = cursor_pos.y - self.position.y
	if y < 0: y = 0
	var c = sqrt(x*x + y*y)
		
	if c != 0:
		var angle = -rad2deg(asin(x/c))
		self.rotation_degrees = angle + 90 
		#print(angle)
		
func _physics_process(delta):
	if get_global_mouse_position().y >= Y_MIN:
		follow_cursor(get_global_mouse_position())
	
# Variant2:
#func _physics_process(delta):
#	if get_global_mouse_position().y >= Y_MIN:
#		var angle = get_global_mouse_position().angle_to_point(position)
#		self.rotation = angle
#		print(angle)
	
# Variant 3:
#func _physics_process(delta):
#	if get_global_mouse_position().y >= Y_MIN:
#		look_at(get_global_mouse_position())
#		
