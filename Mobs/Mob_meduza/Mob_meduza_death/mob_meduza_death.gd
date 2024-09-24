extends AnimatedSprite2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var mob_meduza_death: String = "mob_meduza_death"

func _on_animation_finished():
	Global.ochki += 1000
	queue_free()
