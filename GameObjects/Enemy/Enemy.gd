extends KinematicBody2D


var bullet = preload("res://GameObjects/Enemy/Bullet.tscn")
var bullet_startPosition = Vector2()
onready var rotator_node = get_node("rotator")
onready var timer = get_node("BulletSpawnDelay")


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.set_wait_time(1)
	timer.start()
	rotator_node.position = self.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	pass


func _spawn_bullet_rotation():
	rotator_node.rotate(1)
	var bullet_instance = bullet.instance()
	bullet_instance.position = rotator_node.position
	bullet_instance.rotation = rotator_node.rotation
	get_parent().add_child(bullet_instance)

func _spawn_bullets_at_once():
	var bullet_instances = []
	var bullet_rotation = []
	var rotation_interval = 15
	var result = 0
	var bullet_amount = 23
	
	for i in range(0, bullet_amount):
		result += rotation_interval
		bullet_rotation.push_back(result)
		bullet_instances.push_back(bullet.instance())
		rotator_node.rotate(bullet_rotation[i])
		bullet_instances[i].position = rotator_node.position
		bullet_instances[i].rotation = rotator_node.rotation
		get_parent().add_child(bullet_instances[i])
	
	


func _on_Timer_timeout():
	_spawn_bullets_at_once()
	
