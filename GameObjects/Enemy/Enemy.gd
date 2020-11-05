extends KinematicBody2D


var bullet = preload("res://GameObjects/Bullet/Bullet.tscn")
var bullet_startPosition = Vector2()
export var fire_delay = 0.8
export var health = 100
onready var rotator_node = get_node("rotator")
onready var timer = get_node("BulletSpawnDelay")
var can_fire = false

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.set_wait_time(fire_delay)
	timer.start()
	rotator_node.position = self.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	_calculate_health()
	


func _spawn_bullet_rotation():
	rotator_node.rotate(1)
	var bullet_instance = bullet.instance()
	bullet_instance.position = rotator_node.position
	bullet_instance.rotation = rotator_node.rotation
	get_parent().add_child(bullet_instance)

func _spawn_bullets_at_once():
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
		rotator_node.rotate(bullet_rotation[i])
		bullet_instances[i].position = rotator_node.position
		bullet_instances[i].rotation = rotator_node.rotation
		get_parent().add_child(bullet_instances[i])
	
	
func _calculate_health():
	if(!health > 0):
		get_tree().queue_delete(self)

func _on_Timer_timeout():
	can_fire = true
	
