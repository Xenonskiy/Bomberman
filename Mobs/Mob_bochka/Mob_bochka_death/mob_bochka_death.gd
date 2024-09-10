extends AnimatedSprite2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var mob_bochka_death: String = "mob_bochka_death"

func _on_animation_finished():
	Global.ochki += 400
	print(Global.ochki)
	queue_free()
