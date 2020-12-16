extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var health = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite/AnimationPlayer.play("Pulse")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health <= 0:
		queue_free()


func _on_Timer_timeout():
	var enemies = get_tree().get_nodes_in_group("Enemy")
	for enemy in enemies:
		if enemy.health != 3000:
			enemy.health += 40
