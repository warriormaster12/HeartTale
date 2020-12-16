extends KinematicBody2D


var bullet = preload("res://GameObjects/Bullet/Bullet.tscn")
var bullet_startPosition = Vector2()
export var fire_delay = 0.8
export var health = 5000
export(Array, NodePath) var targets
export (NodePath) var sfx_audio_source 
export (float) var speed = 3.0

onready var rotator_node = get_node("rotator")
onready var timer = get_node("BulletSpawnDelay")
onready var sfx_audio_source_node = get_node(sfx_audio_source) 

onready var starting_color = $Sprite.modulate
var grey_color = Color(0.5,0.5,0.5)


var can_fire = false
var new_pos
var can_move = false
var do_once = true
var god_mode = false

var current_target
onready var starting_position = self.position
var move_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.set_wait_time(fire_delay)
	timer.start()
	rotator_node.position = self.position

	
	if do_once == true:
		current_target = get_node(targets[rand_range(0, targets.size())])
		do_once = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	_calculate_health()
	_calculate_position(delta)
	if(god_mode == true):
		$Sprite.modulate = grey_color
	else:
		$Sprite.modulate = starting_color
	
	
	


func _spawn_bullet_rotation(delta):
	var speed = 50
	rotator_node.rotate(speed * delta)
	var bullet_instance = bullet.instance()
	bullet_instance.position = rotator_node.position
	bullet_instance.rotation = rotator_node.rotation
	get_parent().add_child(bullet_instance)
	sfx_audio_source_node.play()

func _shoot_laser(delta):
	var bullet_instance = bullet.instance()
	var speed = 1
	rotator_node.rotate(speed * delta)
	bullet_instance.position = rotator_node.position
	bullet_instance.rotation = rotator_node.rotation
	get_parent().add_child(bullet_instance)
	sfx_audio_source_node.play()

func _spawn_bullets_at_once(delta):
	can_fire = false
	var bullet_instances = []
	var bullet_rotation = []
	var rotation_interval = rand_range(24, 15)
	var result = 0
	var bullet_amount = rand_range(15, 24)
	
	for i in range(0, bullet_amount-1):
		result += rotation_interval
		bullet_rotation.push_back(result)
		bullet_instances.push_back(bullet.instance())
		rotator_node.rotate(bullet_rotation[i] * delta)
		bullet_instances[i].position = rotator_node.position
		bullet_instances[i].rotation = rotator_node.rotation
		get_parent().add_child(bullet_instances[i])
		sfx_audio_source_node.play()
	
	
func _calculate_health():
	if(!health > 0):
		get_tree().change_scene("res://Levels/MainMenu.tscn")
func _calculate_position(delta):
	var distance = current_target.position - self.position
	new_pos = current_target.position
	if move_count < 10 && can_move == true:
		if(distance.length() > 100):
			_move(delta)
		else: 
			move_count +=1
			current_target = get_node(targets[rand_range(0, targets.size())])
	else: 
		new_pos = starting_position
		_move(delta)
		move_count = 0
		can_move = false
		
		
		
	
func _move(delta):
	rotator_node.position = self.position
	var t = 0
	t += delta * speed
	self.position = self.position.linear_interpolate(new_pos, t)

func _on_Timer_timeout():
	can_fire = true
	
