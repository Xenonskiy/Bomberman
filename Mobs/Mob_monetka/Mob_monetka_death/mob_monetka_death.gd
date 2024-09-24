extends AnimatedSprite2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var mob_monetka_death: String = "mob_monetka_death"

func _on_animation_finished():
	Global.ochki += 8000
	queue_free()
