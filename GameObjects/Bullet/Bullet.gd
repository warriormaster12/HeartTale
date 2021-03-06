extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dir = Vector2(1,0)
var speed = 500
export (NodePath) var sfx_audio_source 
onready var sfx_audio_source_node = get_node(sfx_audio_source) 
onready var timer = get_node("SelfDestroyDelay")
var target = "Player"
var damage = 20.0



# Called when the node enters the scene tree for the first time.
func _ready():
	timer.set_wait_time(6)
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	self.position += dir.rotated(self.rotation) * speed * delta
	
	


func _on_Area2D_body_entered(body):
	if body.is_in_group("BloodGenerators"):
		body.health -= damage
		$Sprite.visible = false
		sfx_audio_source_node.play()
	if body.name == target:
		if body.get("camera_node") != null:
			body.camera_node._play_animation()
		
		
		if !body.get("god_mode") or body.get("god_mode") == false:
			body.health -= damage
			$HitParticle._emit_particles()
		$Sprite.visible = false
		sfx_audio_source_node.play()
	


	


func _on_Timer_timeout():
	get_tree().queue_delete(self)
