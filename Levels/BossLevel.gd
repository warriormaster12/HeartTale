extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var do_once = true
var another_do_once = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var generators = get_tree().get_nodes_in_group("BloodGenerators")
	var camera_position = _get_camera_center()
	if $Enemy != null:
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
		if $Enemy.god_mode == true and $Enemy/BTRoot.stages == 6:
			if another_do_once == true:
				for i in range(0, 4):
					var generator = load("res://GameObjects/HealthPack/BloodGenerators.tscn").instance()
					var generator_pos = Vector2(camera_position.x + rand_range(-300, 300), camera_position.y + rand_range(-300, 300))
					generator.position = generator_pos
					add_child(generator)
					another_do_once = false
			
		if generators.size() == 0 and $Enemy/BTRoot.stages > 6:
			another_do_once = true
			$Enemy.god_mode = false

func _get_camera_center():
	var vtrans = get_canvas_transform()
	var top_left = -vtrans.get_origin() / vtrans.get_scale()
	var vsize = get_viewport_rect().size
	return top_left + 0.5*vsize/vtrans.get_scale()
