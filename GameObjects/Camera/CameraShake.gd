extends Camera2D


export var amplitude = 6.0
export var duration = 0.8 setget _set_duration
export (float, EASE) var DAMP_EASING = 1.0
export var shake = false setget _set_shake

onready var timer = get_node("ShakeTime")

var enabled = false
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	set_process(false)
	self.duration = duration
	_connect_to_shake()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var damping = ease(timer.time_left / timer.wait_time, DAMP_EASING)
	offset = Vector2(rand_range(amplitude, -amplitude) * damping, rand_range(amplitude, -amplitude) * damping)

func _set_duration(value: float):
	duration = value 
	timer.set_wait_time(duration)
func _set_shake(value: bool):
	shake = value 
	set_process(shake)
	

func _on_ShakeTime_timeout():
	self.shake = false 
	offset = Vector2()
	if shake :
		timer.start()
	
func _on_camera_shake_requested():
	if not enabled: 
		return
	self.shake = true 
func _connect_to_shake():
	for camera_shaker in get_tree().get_nodes_in_group("camera_shake"):
		camera_shaker.connect("camera_shake_requested", self, "_on_camera_make_requested")
