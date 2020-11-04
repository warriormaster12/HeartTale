extends KinematicBody2D


var bullet = preload("res://GameObjects/Enemy/Bullet.tscn")
var bullet_startPosition = Vector2()
export (NodePath) var rotator
onready var rotator_node = get_node(rotator)
onready var timer = get_node("BulletSpawnDelay")


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.set_wait_time(0.1)
	timer.start()
	rotator_node.position = self.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	pass


func _spawn_bullet():
	rotator_node.rotate(1)
	var bullet_instance = bullet.instance()
	bullet_instance.position = rotator_node.position
	bullet_instance.rotation = rotator_node.rotation
	get_parent().add_child(bullet_instance)
	


func _on_Timer_timeout():
	_spawn_bullet()
