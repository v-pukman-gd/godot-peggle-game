extends Node2D

func _ready():
	pass

func _input(event):
	if event is InputEventMouseButton:
		print("Mouse click at:", event.position)
		
func _process(delta):
	pass
	
func _physics_process(delta):
	if get_global_mouse_position().y >= self.position.y:
		var d = self.global_position - get_global_mouse_position()
		var offset = -PI
		var r = d.angle() + offset
		self.rotation = lerp_angle(self.rotation, r, 0.25)
	
# Variant 1:
#const Y_MIN = 100
#func follow_cursor(cursor_pos):
#	var x = cursor_pos.x - self.position.x
#	var y = cursor_pos.y - self.position.y
#	if y < 0: y = 0
#	var c = sqrt(x*x + y*y)
#
#	if c != 0:
#		var angle = -rad2deg(asin(x/c)) + 90
#		self.rotation_degrees = angle
#		print(angle)
#
#func _physics_process(delta):
#	if get_global_mouse_position().y >= Y_MIN:
#		follow_cursor(get_global_mouse_position())
#
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
