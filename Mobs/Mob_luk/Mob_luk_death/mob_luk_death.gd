extends AnimatedSprite2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var mob_luk_death: String = "mob_luk_death"

func _on_animation_finished():
	Global.ochki += 200
	queue_free()
