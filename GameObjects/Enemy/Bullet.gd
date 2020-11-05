extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dir = Vector2(1,0)
var speed = 400
onready var timer = get_node("SelfDestroyDelay")

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.set_wait_time(10)
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	self.position += dir.rotated(self.rotation) * speed * delta
	


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		print("Hit")
		#get_tree().queue_delete(self)


	


func _on_Timer_timeout():
	get_tree().queue_delete(self)
