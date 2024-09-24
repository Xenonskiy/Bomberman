extends StaticBody2D
	
func _on_animated_sprite_2d_animation_finished():
	queue_free()
	
func _on_area_2d_body_entered(player):
	if player.has_method("destroy") and not player.has_been_destroyed:
		player.destroy()
		
func _on_area_2d_3_body_entered(block_kirpich):
	if block_kirpich.has_method("destroy_for_mob_b"):
		block_kirpich.destroy_for_mob_b()

		
		
