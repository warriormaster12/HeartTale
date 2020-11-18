extends ProgressBar


export(NodePath) var target 
onready var target_node = get_node(target)
var current_health = 0.0
var max_health = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	if target_node.get("health"):
		max_health = target_node.health
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if target_node.get("health"):
		current_health = target_node.health  
		$".".value = (current_health/max_health)*100
	
	

