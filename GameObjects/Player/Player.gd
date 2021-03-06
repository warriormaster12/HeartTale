extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var Speed = 300.0
export var fire_delay = 0.1
export var health = 100
export (NodePath) var sfx_audio_source 

export (NodePath) var camera 


var direction = Vector2()
var velocity = Vector2()

onready var camera_node = get_node(camera)
onready var rotator_node = get_node("rotator")
onready var timer = get_node("ShootingTimer")
onready var sfx_audio_source_node = get_node(sfx_audio_source) 
var bullet = preload("res://GameObjects/Bullet/Bullet.tscn")
var can_shoot = true



# Called when the node enters the scene tree for the first time.
func _ready():
	timer.set_wait_time(fire_delay)
	timer.one_shot = true
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	direction = Vector2()
	rotator_node.position = self.position
	
	_calculate_health()

	if Input.is_action_pressed("move_r"):
		 direction.x += 1 
	if Input.is_action_pressed("move_l"):
		 direction.x -= 1 
	if Input.is_action_pressed("move_f"):
		direction.y -= 1
	if Input.is_action_pressed("move_b"):
		direction.y += 1
	if Input.is_action_pressed("fire") && can_shoot == true:
		_shoot()
	if Input.is_action_pressed("restart_game"):
		get_tree().reload_current_scene()
	
	direction = direction.normalized() 
	velocity = direction * Speed * delta
	
	move_and_collide(velocity)

func _shoot():
	var bullet_instance = bullet.instance()
	bullet_instance.target = "Enemy"
	bullet_instance.speed = 1000
	
	var bullet_rotation = get_angle_to(get_global_mouse_position()) + rotator_node.get_rotation()
	bullet_instance.position = rotator_node.position
	bullet_instance.rotation = bullet_rotation
	get_parent().add_child(bullet_instance)
	can_shoot = false
	timer.start()
	sfx_audio_source_node.play()

func _calculate_health():
	if(!health > 0):
		get_tree().reload_current_scene()

func _on_ShootingTimer_timeout():
	can_shoot = true
