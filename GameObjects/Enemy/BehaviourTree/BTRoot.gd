extends Node2D


export (NodePath) var ai_target
onready var ai_target_node = get_node(ai_target)
onready var active_node = get_node("Stage")
onready var timer = get_node("BehaviourExecutionTimer")
var stages = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()
	stages +=1
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active_node == get_node("Stage"):
		if stages == 0: 
			timer.set_wait_time(1.0)
		if stages  == 1 : 
			timer.set_wait_time(5.0)
			if ai_target_node.can_fire == true:
				ai_target_node._spawn_bullets_at_once()
			
		elif stages == 2: 
			timer.set_wait_time(2.0)
			ai_target_node._spawn_bullet_rotation()
			
		print(timer.time_left)
	print(stages)
	


func _on_BehaviourExecutionTimer_timeout():
	stages +=1
	if stages == 3:
		stages = 0
