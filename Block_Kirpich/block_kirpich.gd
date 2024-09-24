extends StaticBody2D

var mob_list = []  # Список для хранения ссылок на все мобы, которые будут уничтожены

func destroy():
	$Timer.start()
	for mob in mob_list:
		mob.destroy()
	mob_list.clear()

# Эта функция для уничтожения кирпичного блока от моба бомбы. Мобы, которые 
# находятся в кирпичных блоках не будут уничтожены
func destroy_for_mob_b():
	$Timer.start()
	
func _on_timer_timeout():
	# Получаем координаты текущего блока
	var block_position = self.get_position()
	
	# Удаляем координаты блока из глобального массива
	var new_coordinates_with_block_kirpich = []
	for coord in Global.coordinates_with_block_kirpich:
		if coord != block_position:
			new_coordinates_with_block_kirpich.append(coord)
	Global.coordinates_with_block_kirpich = new_coordinates_with_block_kirpich
	
	# На месте уничтожаемого блока спаунится его анимация
	var new_object = load("res://Block_Kirpich_destroy/block_kirpich_destroy.tscn").instantiate()
	new_object.global_position = global_position
	get_parent().add_child(new_object)
	queue_free()
	
	
func _on_area_2d_body_entered(mob_meduza):
	mob_list.append(mob_meduza)

func _on_area_2d_2_body_entered(mob_prividenie):
	mob_list.append(mob_prividenie)
	
func _on_area_2d_body_exited(mob_meduza):
	mob_list.erase(mob_meduza)
	
func _on_area_2d_2_body_exited(mob_prividenie):
	mob_list.erase(mob_prividenie)
	
func _on_area_2d_3_body_entered(mob_monetka):
	mob_list.append(mob_monetka)
	
func _on_area_2d_3_body_exited(mob_monetka):
	mob_list.erase(mob_monetka)
