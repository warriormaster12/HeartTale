extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var Speed = 300.0
var direction = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	direction = Vector2()
	#if Input.is_action_pressed("Jump"):
		
	if Input.is_action_pressed("move_r"):
		 direction.x += 1 
	if Input.is_action_pressed("move_l"):
		 direction.x -= 1 
	if Input.is_action_pressed("move_f"):
		direction.y -= 1
	if Input.is_action_pressed("move_b"):
		direction.y += 1
	
	direction = direction.normalized() * Speed
	direction = direction
	
	direction = move_and_slide(direction)
