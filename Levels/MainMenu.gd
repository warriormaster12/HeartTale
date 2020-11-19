extends Control


export(String) var load_level



# Called when the node enters the scene tree for the first time.

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Start_game__pressed():
	get_tree().change_scene(load_level)


func _on_Quit_game_pressed():
	get_tree().quit()
