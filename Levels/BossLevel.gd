extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var do_once = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var camera_position = _get_camera_center()
	if $Enemy.god_mode == true:
		if do_once == true:
			for i in range(0, 3):
				var healthpack = load("res://GameObjects/HealthPack/Health.tscn").instance()
				var healthpack_pos = Vector2(camera_position.x + rand_range(-300, 300), camera_position.y + rand_range(-300, 300))
				healthpack.position = healthpack_pos
				add_child(healthpack)
				do_once = false
	else: 
		do_once = true

func _get_camera_center():
	var vtrans = get_canvas_transform()
	var top_left = -vtrans.get_origin() / vtrans.get_scale()
	var vsize = get_viewport_rect().size
	return top_left + 0.5*vsize/vtrans.get_scale()
