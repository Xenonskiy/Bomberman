extends AnimatedSprite2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var mob_kolobok_death: String = "mob_kolobok_death"

func _on_animation_finished():
	Global.ochki += 800
	queue_free()
