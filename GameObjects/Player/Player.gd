extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var Speed = 300.0
var direction = Vector2()
onready var rotator_node = get_node("rotator")
var bullet = preload("res://GameObjects/Enemy/Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	direction = Vector2()
	
	rotator_node.look_at(get_global_mouse_position())
	if Input.is_action_pressed("move_r"):
		 direction.x += 1 
	if Input.is_action_pressed("move_l"):
		 direction.x -= 1 
	if Input.is_action_pressed("move_f"):
		direction.y -= 1
	if Input.is_action_pressed("move_b"):
		direction.y += 1
	if Input.is_action_pressed("fire"):
		_shoot()
	
	direction = direction.normalized() 
	direction = direction * Speed
	
	direction = move_and_slide(direction)

func _shoot():
	rotator_node.position = self.position
	var bullet_instance = bullet.instance()
	bullet_instance.position = rotator_node.position
	bullet_instance.rotation = rotator_node.rotation
	get_parent().add_child(bullet_instance)
