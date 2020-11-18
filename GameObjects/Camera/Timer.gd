extends HBoxContainer


var minutes = 0
var seconds = 0
var stop_timer = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if(stop_timer == false):
		if(seconds > 59):
			minutes+=1
			seconds= 0
	$Minutes.text = String(minutes)
	$Seconds.text = String(seconds)


func _on_Timer_timeout():
	if(stop_timer == false):
		seconds+=1
