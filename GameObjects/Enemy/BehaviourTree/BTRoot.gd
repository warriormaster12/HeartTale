extends Node2D


export (NodePath) var ai_target
onready var ai_target_node = get_node(ai_target)
onready var active_node = get_node("Stage")
onready var timer = get_node("BehaviourExecutionTimer")
var can_trigger = true
var stages = 0
var do_once = true
var another_do_once = true


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.one_shot = true
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if active_node == get_node("Stage"):	
		if stages == 0: 
			ai_target_node.god_mode = false
			do_once = true
			another_do_once = true
			_wait(1.0)
		elif stages == 1: 
			_wait(5.0)
			if ai_target_node.can_fire == true:
				ai_target_node._spawn_bullets_at_once(delta)
		elif stages == 2: 
			_wait(1.0)
			ai_target_node._spawn_bullet_rotation(delta)
		elif stages == 3: 
			_wait(3.0)
		elif stages == 4: 
			_wait(5.0)
			ai_target_node.god_mode = true
			ai_target_node._shoot_laser(delta)
			_wait(5.0)
		elif stages == 5:
			ai_target_node.god_mode = false
			if do_once == true:
				do_once = false
				ai_target_node.can_move = true
			
			if ai_target_node.can_move == false:
				_wait(2.5)
		elif stages == 6:
			_wait(5.0)
			if another_do_once == true:
				ai_target_node.god_mode = true
				another_do_once = false
			#if ai_target_node.god_mode == false and another_do_once == false:
			#	_wait(5.0)


func _wait(wait_time):
	if can_trigger == true:
		timer.set_wait_time(wait_time)
		timer.start()
		can_trigger = false


func _on_BehaviourExecutionTimer_timeout():
	can_trigger = true
	stages +=1
	if stages > 6:
		stages = 0

	
