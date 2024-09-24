extends AnimatedSprite2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var mob_b_death: String = "mob_b_death"

func _on_animation_finished():
	Global.ochki += 4000
	queue_free()
