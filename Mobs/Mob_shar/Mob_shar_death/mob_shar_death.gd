extends AnimatedSprite2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var mob_shar_death: String = "mob_shar_death"

func _on_animation_finished():
	Global.ochki += 100
	queue_free()
	
