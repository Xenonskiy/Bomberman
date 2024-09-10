extends AnimatedSprite2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var mob_block_death: String = "mob_block_death"

func _on_animation_finished():
	Global.ochki += 100
	queue_free()
