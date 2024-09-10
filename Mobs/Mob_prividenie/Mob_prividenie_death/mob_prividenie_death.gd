extends AnimatedSprite2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var mob_prividenie_death: String = "mob_prividenie_death"

func _on_animation_finished():
	Global.ochki += 2000
	print(Global.ochki)
	queue_free()
