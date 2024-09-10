extends StaticBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var block_kirpich_destroy: String = "block_kirpich_destroy"

func _on_animated_sprite_2d_animation_finished():
	queue_free()
