extends StaticBody2D

enum Type {BLUE, RED, PURPLE}
export(Type) var type = Type.BLUE
export(int) var points = 10

onready var sprite = $Sprite
onready var game = get_node("/root/Game")

var collected = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func setup():
	pass
#	match type:
#		Type.BLUE:
#			print("blue")
#		Type.RED:
#			print("red")
#		Type.PURPLE:
#			print("purple")


func hit_by_ball():
	if collected: return
	
	sprite.modulate = Color(1.5, 1.5, 1.5, 1 )
	game.on_peg_collected(self)
	collected = true
	#queue_free()
