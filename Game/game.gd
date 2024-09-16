extends Node2D

const blok_kirpich_preload = preload("res://Block_Kirpich/block_kirpich.tscn")
const mob_shar_preload = preload("res://Mobs/Mob_shar/mob_shar.tscn")
const mob_monetka_preload = preload("res://Mobs/Mob_monetka/mob_monetka.tscn")
const mob_bochka_preload = preload("res://Mobs/Mob_bochka/mob_bochka.tscn")
const mob_luk_preload = preload("res://Mobs/Mob_luk/mob_luk.tscn")
const mob_kolobok_preload = preload("res://Mobs/Mob_kolobok/mob_kolobok.tscn")
const mob_roja_preload = preload("res://Mobs/Mob_roja/mob_roja.tscn")
const mob_meduza_preload = preload("res://Mobs/Mob_meduza/mob_meduza.tscn")
const mob_prividenie_preload = preload("res://Mobs/Mob_prividenie/mob_prividenie.tscn")
const mob_block_preload = preload("res://Mobs/Mob_block/mob_block.tscn")
const mob_b_preload = preload("res://Mobs/Mob_b/mob_b.tscn")


var svobodnie_koordinati_rjadom_s_igrokom: Array[Vector2] = [Vector2(72,168),
Vector2(120,168),
Vector2(168,168),
Vector2(216,168),
Vector2(72,216),
Vector2(168,216),
Vector2(72,264),
Vector2(120,264),
Vector2(168,264),
Vector2(216,264),
Vector2(72,312),
Vector2(168,312)]
 
func _ready():
	$Timer.start()
	
	# Переменная, содержащая количество кирпичных блоков, в зависимости от номера стадии
	var kolichestvo_blokov_dla_stadii: int = 50 + (5 * Global.stage_nomer)
	
	# Добавление в массив Global.coordinates_with_block_kirpich случайные элементы из массива Global.all_coordinates
	var unique_indices = []
	while Global.coordinates_with_block_kirpich.size() < kolichestvo_blokov_dla_stadii and unique_indices.size() < Global.all_coordinates.size():
		var random_index = randi() % Global.all_coordinates.size()
		if !unique_indices.has(random_index):
			Global.coordinates_with_block_kirpich.append(Global.all_coordinates[random_index])
			unique_indices.append(random_index)
	# В массив Global.svobodnie_coordinates добавляются координаты в которых нет блоков с кирпичами
	for coordinate in Global.all_coordinates:
		if !Global.coordinates_with_block_kirpich.has(coordinate):
			Global.svobodnie_coordinates.append(coordinate)
	# Удаляю из массива svobodnie_coordinates координаты рядом с игроком, чтобы мобы не появлялись в начале игры около игрока
	var novij_global_coordinates = []
	for coord in Global.svobodnie_coordinates:
		var contains = false
		for coord_rjadom in svobodnie_koordinati_rjadom_s_igrokom:
			if coord == coord_rjadom:
				contains = true
				break
		if not contains:
			novij_global_coordinates.append(coord)
	Global.svobodnie_coordinates = novij_global_coordinates
		
	blok_kirpich_spawn()
		
	# Выбираю 1 случайную координату для item
	var random_index_for_item = randi_range(0, Global.coordinates_with_block_kirpich.size() - 1)
	Global.coordinate_item = Global.coordinates_with_block_kirpich[random_index_for_item]
	
	# Выбираю 1 случайную координату для vorota 
	var random_index_for_vorota = randi_range(0, Global.coordinates_with_block_kirpich.size() - 1)
	Global.coordinate_vorota = Global.coordinates_with_block_kirpich[random_index_for_vorota]
	# Цикл нужен, чтобы координаты итема не совпали с воротами
	while Global.coordinate_vorota == Global.coordinate_item:
		random_index_for_vorota = randi_range(0, Global.coordinates_with_block_kirpich.size() - 1)
		Global.coordinate_vorota = Global.coordinates_with_block_kirpich[random_index_for_vorota]
	
	# Создаю итем
	var item
	if Global.stage_nomer == 1:
		item = $item_lazer
	elif Global.stage_nomer == 2:
		item = $item_b
	elif Global.stage_nomer == 3:
		item = $item_speed
	elif Global.stage_nomer == 4:
		item = $item_lazer
	elif Global.stage_nomer == 5:
		item = $item_lazer
	elif Global.stage_nomer == 6:
		item = $item_skvoz_steni
	elif Global.stage_nomer == 7:
		item = $item_knopka
	elif Global.stage_nomer == 8:
		item = $item_b
	elif Global.stage_nomer == 9:
		item = $item_flamepass
	elif Global.stage_nomer == 10:
		item = $item_lazer
	else:
		item = $item_lazer
	item.position = Global.coordinate_item  
	
	# Создание ворот 
	var vorota = $vorota
	vorota.position = Global.coordinate_vorota 
	
	# Создание мобов в начале игры. В зависимости от стадии
	if Global.stage_nomer == 1:
		mob_shar_spawn()
		mob_shar_spawn()
		mob_shar_spawn()
		mob_shar_spawn()
		mob_shar_spawn()
		mob_shar_spawn()
		if Global.novie_mobi == true:
			mob_block_spawn()
			mob_bomb_spawn()
	elif Global.stage_nomer == 2:
		mob_shar_spawn()
		mob_shar_spawn()
		mob_shar_spawn()
		mob_luk_spawn()
		mob_luk_spawn()
		mob_luk_spawn()
		if Global.novie_mobi == true:
			mob_block_spawn()
			mob_bomb_spawn()
	elif Global.stage_nomer == 3:
		mob_shar_spawn()
		mob_shar_spawn()
		mob_luk_spawn()
		mob_luk_spawn()
		mob_bochka_spawn()
		mob_bochka_spawn()
		if Global.novie_mobi == true:
			mob_block_spawn()
			mob_bomb_spawn()
	elif Global.stage_nomer == 4:
		mob_shar_spawn()
		mob_luk_spawn()
		mob_bochka_spawn()
		mob_bochka_spawn()
		mob_kolobok_spawn()
		mob_kolobok_spawn()
		if Global.novie_mobi == true:
			mob_block_spawn()
			mob_bomb_spawn()
	elif Global.stage_nomer == 5:
		mob_shar_spawn()
		mob_luk_spawn()
		mob_bochka_spawn()
		mob_bochka_spawn()
		mob_kolobok_spawn()
		mob_roja_spawn()
		mob_roja_spawn()
		if Global.novie_mobi == true:
			mob_block_spawn()
			mob_bomb_spawn()
	elif Global.stage_nomer == 6:
		mob_shar_spawn()
		mob_luk_spawn()
		mob_bochka_spawn()
		mob_kolobok_spawn()
		mob_roja_spawn()
		mob_meduza_spawn()
		mob_meduza_spawn()
		if Global.novie_mobi == true:
			mob_block_spawn()
			mob_bomb_spawn()
	elif Global.stage_nomer == 7:
		mob_luk_spawn()
		mob_luk_spawn()
		mob_bochka_spawn()
		mob_kolobok_spawn()
		mob_roja_spawn()
		mob_meduza_spawn()
		mob_prividenie_spawn()
		mob_prividenie_spawn()
		mob_prividenie_spawn()
		if Global.novie_mobi == true:
			mob_block_spawn()
			mob_bomb_spawn()
	elif Global.stage_nomer == 8:
		mob_shar_spawn()
		mob_luk_spawn()
		mob_bochka_spawn()
		mob_kolobok_spawn()
		mob_roja_spawn()
		mob_meduza_spawn()
		mob_prividenie_spawn()
		mob_monetka_spawn()
		mob_monetka_spawn()
		if Global.novie_mobi == true:
			mob_block_spawn()
			mob_bomb_spawn()
	elif Global.stage_nomer == 9:
		mob_luk_spawn()
		mob_bochka_spawn()
		mob_kolobok_spawn()
		mob_kolobok_spawn()
		mob_roja_spawn()
		mob_meduza_spawn()
		mob_prividenie_spawn()
		mob_monetka_spawn()
		mob_monetka_spawn()
		if Global.novie_mobi == true:
			mob_block_spawn()
			mob_bomb_spawn()
	elif Global.stage_nomer >= 10 and Global.stage_nomer <= 15:
		mob_shar_spawn()
		mob_luk_spawn()
		mob_bochka_spawn()
		mob_bochka_spawn()
		mob_kolobok_spawn()
		mob_roja_spawn()
		mob_meduza_spawn()
		mob_prividenie_spawn()
		mob_monetka_spawn()
		mob_monetka_spawn()
		if Global.novie_mobi == true:
			mob_block_spawn()
			mob_bomb_spawn()
	
# Создание кирпичных блоков на сцене, равное количеству элементов в массиве Global.coordinates_with_block_kirpich
func blok_kirpich_spawn():
	for i in range(Global.coordinates_with_block_kirpich.size()):
		var blok_kirpich_new = blok_kirpich_preload.instantiate()
		blok_kirpich_new.position = Global.coordinates_with_block_kirpich[i]
		$bloki_kirpichi.add_child(blok_kirpich_new)
		
# Создание мобов-шаров на свободных от кирпичных блоках координатах
func mob_shar_spawn():
	for i in range(1 * Global.more_enemy):
		var mob_shar_new = mob_shar_preload.instantiate()
		var random_index = randi_range(0, Global.svobodnie_coordinates.size() - 1)
		mob_shar_new.position = Global.svobodnie_coordinates[random_index]
		$Mobs.add_child(mob_shar_new)
		Global.massiv_vse_sozdannie_mobi.append(mob_shar_new) 
		
func mob_monetka_spawn():
	for i in range(1 * Global.more_enemy):
		var mob_monetka_new = mob_monetka_preload.instantiate()
		var random_index = randi_range(0, Global.svobodnie_coordinates.size() - 1)
		mob_monetka_new.position = Global.svobodnie_coordinates[random_index]
		$Mobs.add_child(mob_monetka_new)
		Global.massiv_vse_sozdannie_mobi.append(mob_monetka_new)

func mob_bochka_spawn():
	for i in range(1 * Global.more_enemy):
		var mob_bochka_new = mob_bochka_preload.instantiate()
		var random_index = randi_range(0, Global.svobodnie_coordinates.size() - 1)
		mob_bochka_new.position = Global.svobodnie_coordinates[random_index]
		$Mobs.add_child(mob_bochka_new)
		Global.massiv_vse_sozdannie_mobi.append(mob_bochka_new)

func mob_luk_spawn():
	for i in range(1 * Global.more_enemy):
		var mob_luk_new = mob_luk_preload.instantiate()
		var random_index = randi_range(0, Global.svobodnie_coordinates.size() - 1)
		mob_luk_new.position = Global.svobodnie_coordinates[random_index]
		$Mobs.add_child(mob_luk_new)
		Global.massiv_vse_sozdannie_mobi.append(mob_luk_new)

func mob_kolobok_spawn():
	for i in range(1 * Global.more_enemy):
		var mob_kolobok_new = mob_kolobok_preload.instantiate()
		var random_index = randi_range(0, Global.svobodnie_coordinates.size() - 1)
		mob_kolobok_new.position = Global.svobodnie_coordinates[random_index]
		$Mobs.add_child(mob_kolobok_new)
		Global.massiv_vse_sozdannie_mobi.append(mob_kolobok_new)

func mob_roja_spawn():
	for i in range(1 * Global.more_enemy):
		var mob_roja_new = mob_roja_preload.instantiate()
		var random_index = randi_range(0, Global.svobodnie_coordinates.size() - 1)
		mob_roja_new.position = Global.svobodnie_coordinates[random_index]
		$Mobs.add_child(mob_roja_new)
		Global.massiv_vse_sozdannie_mobi.append(mob_roja_new)

func mob_meduza_spawn():
	for i in range(1 * Global.more_enemy):
		var mob_meduza_new = mob_meduza_preload.instantiate()
		var random_index = randi_range(0, Global.svobodnie_coordinates.size() - 1)
		mob_meduza_new.position = Global.svobodnie_coordinates[random_index]
		$Mobs.add_child(mob_meduza_new)
		Global.massiv_vse_sozdannie_mobi.append(mob_meduza_new)

func mob_prividenie_spawn():
	for i in range(1 * Global.more_enemy):
		var mob_prividenie_new = mob_prividenie_preload.instantiate()
		var random_index = randi_range(0, Global.svobodnie_coordinates.size() - 1)
		mob_prividenie_new.position = Global.svobodnie_coordinates[random_index]
		$Mobs.add_child(mob_prividenie_new)
		Global.massiv_vse_sozdannie_mobi.append(mob_prividenie_new)
		
func mob_block_spawn():
	for i in range(3 * Global.more_enemy):
		var mob_block_new = mob_block_preload.instantiate()
		var random_index = randi_range(0, Global.svobodnie_coordinates.size() - 1)
		mob_block_new.position = Global.svobodnie_coordinates[random_index]
		$Mobs.add_child(mob_block_new)
		Global.massiv_vse_sozdannie_mobi.append(mob_block_new)
		
func mob_bomb_spawn():
	for i in range(3 * Global.more_enemy):
		var mob_b_new = mob_b_preload.instantiate()
		var random_index = randi_range(0, Global.svobodnie_coordinates.size() - 1)
		mob_b_new.position = Global.svobodnie_coordinates[random_index]
		$Mobs.add_child(mob_b_new)
		Global.massiv_vse_sozdannie_mobi.append(mob_b_new)


# Когда в игре истечет время 200 секунд, появятся монетки
func _on_timer_timeout():
	mob_monetka_spawn()
	mob_monetka_spawn()
	mob_monetka_spawn()
	mob_monetka_spawn()
	mob_monetka_spawn()
	mob_monetka_spawn()
	mob_monetka_spawn()

func _on_button_menu_pressed():
	get_tree().paused = true
	$CanvasLayer/PauseMenu.visible = true

func _on_resume_pressed():
	get_tree().paused = false
	$CanvasLayer/PauseMenu.visible = false

func _on_quit_pressed():
	get_tree().quit()


func _on_menu_pressed():
	get_tree().paused = false
	$CanvasLayer/PauseMenu.visible = false
	Global.stage_nomer = 1
	Global.mob_pulki = false
	Global.novie_mobi = false
	Global.nagalKnopkuB = false
	Global.novie_mobi = false
	Global.nagalKnopkuB = false
	Global.chislo_gizney = 11
	Global.player_death = false
	Global.more_enemy = 1
	Global.item_flamepass = false
	Global.speed = 170 
	Global.player_skvoz_steni = 76 
	Global.dlina_lazera = 48 
	Global.dlina_lazera_nomer = 1 
	Global.vzal_item_knopka = false
	Global.ochki = 0
	Global.maximum_b = 1
	Global.vkluchit_Zvuk_B = false
	Global.massiv_vse_sozdannie_mobi.clear()
	Global.coordinates_with_block_kirpich.clear()
	Global.svobodnie_coordinates.clear()
	Global.massiav_s_b.clear()
	Global.massiv_nevidimiy_block.clear()
	Global.massiv_kuda_ustanovlenna_poslednaa_b = []
	Global.coordinate_kuda_ustanovlenna_poslednaa_b = null
	Global.sozdannih_b = 0 
	Global.massiv_block_mobi.clear()
	Global.kamenniy_block_s_blokami_ot_mobov = [
	Vector2(24, 120),
	Vector2(24, 168),
	Vector2(24, 216),
	Vector2(24, 264),
	Vector2(24, 312),
	Vector2(24, 360),
	Vector2(24, 408),
	Vector2(24, 456),
	Vector2(24, 504),
	Vector2(24, 552),
	Vector2(24, 168),
	Vector2(24, 600),
	Vector2(24, 648),
	Vector2(24, 696),
	
	Vector2(72, 696),
	Vector2(120, 696),
	Vector2(168, 696),
	Vector2(216, 696),
	Vector2(264, 696),
	Vector2(312, 696),
	Vector2(360, 696),
	Vector2(408, 696),
	Vector2(456, 696),
	Vector2(504, 696),
	Vector2(552, 696),
	Vector2(600, 696),
	Vector2(648, 696),
	Vector2(696, 696),
	Vector2(744, 696),
	Vector2(792, 696),
	Vector2(840, 696),
	Vector2(888, 696),
	Vector2(936, 696),
	Vector2(984, 696),
	Vector2(1032, 696),
	Vector2(1080, 696),
	Vector2(1128, 696),
	Vector2(1176, 696),
	Vector2(1224, 696),
	Vector2(1272, 696),
	Vector2(1320, 696),
	Vector2(1368, 696),
	Vector2(1416, 696),
	Vector2(1464, 696),
	
	Vector2(1464, 648),
	Vector2(1464, 600),
	Vector2(1464, 552),
	Vector2(1464, 504),
	Vector2(1464, 456),
	Vector2(1464, 408),
	Vector2(1464, 360),
	Vector2(1464, 312),
	Vector2(1464, 264),
	Vector2(1464, 216),
	Vector2(1464, 168),
	Vector2(1464, 120),
		
	Vector2(1416, 120),
	Vector2(1368, 120),
	Vector2(1320, 120),
	Vector2(1272, 120),
	Vector2(1224, 120),
	Vector2(1176, 120),
	Vector2(1128, 120),
	Vector2(1080, 120),
	Vector2(1032, 120),
	Vector2(984, 120),
	Vector2(936, 120),
	Vector2(888, 120),
	Vector2(840, 120),
	Vector2(792, 120),
	Vector2(744, 120),
	Vector2(696, 120),
	Vector2(648, 120),
	Vector2(600, 120),
	Vector2(552, 120),
	Vector2(504, 120),
	Vector2(456, 120),
	Vector2(408, 120),
	Vector2(360, 120),
	Vector2(312, 120),
	Vector2(264, 120),
	Vector2(216, 120),
	Vector2(168, 120),
	Vector2(120, 120),
	Vector2(72, 120),
	
	Vector2(120, 216),
	Vector2(216, 216),
	Vector2(312, 216),
	Vector2(408, 216),
	Vector2(504, 216),
	Vector2(600, 216),
	Vector2(696, 216),
	Vector2(792, 216),
	Vector2(888, 216),
	Vector2(984, 216),
	Vector2(1080, 216),
	Vector2(1176, 216),
	Vector2(1272, 216),
	Vector2(1368, 216),
	
	Vector2(120, 312),
	Vector2(216, 312),
	Vector2(312, 312),
	Vector2(408, 312),
	Vector2(504, 312),
	Vector2(600, 312),
	Vector2(696, 312),
	Vector2(792, 312),
	Vector2(888, 312),
	Vector2(984, 312),
	Vector2(1080, 312),
	Vector2(1176, 312),
	Vector2(1272, 312),
	Vector2(1368, 312),
	
	Vector2(120, 408),
	Vector2(216, 408),
	Vector2(312, 408),
	Vector2(408, 408),
	Vector2(504, 408),
	Vector2(600, 408),
	Vector2(696, 408),
	Vector2(792, 408),
	Vector2(888, 408),
	Vector2(984, 408),
	Vector2(1080, 408),
	Vector2(1176, 408),
	Vector2(1272, 408),
	Vector2(1368, 408),
	
	Vector2(120, 504),
	Vector2(216, 504),
	Vector2(312, 504),
	Vector2(408, 504),
	Vector2(504, 504),
	Vector2(600, 504),
	Vector2(696, 504),
	Vector2(792, 504),
	Vector2(888, 504),
	Vector2(984, 504),
	Vector2(1080, 504),
	Vector2(1176, 504),
	Vector2(1272, 504),
	Vector2(1368, 504),
	
	Vector2(120, 600),
	Vector2(216, 600),
	Vector2(312, 600),
	Vector2(408, 600),
	Vector2(504, 600),
	Vector2(600, 600),
	Vector2(696, 600),
	Vector2(792, 600),
	Vector2(888, 600),
	Vector2(984, 600),
	Vector2(1080, 600),
	Vector2(1176, 600),
	Vector2(1272, 600),
	Vector2(1368, 600)]
	get_tree().change_scene_to_file("res://Menu/menu.tscn")


func _on_audio_stream_player_2d_finished():
	$AudioStreamPlayer2D.play()
func _on_audio_stream_player_2d_2_finished():
	$AudioStreamPlayer2D2.play()
