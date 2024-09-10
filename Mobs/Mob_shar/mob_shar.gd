extends CharacterBody2D

var pulka = preload("res://Pulka/pulka.tscn")

var has_destroyed = false # Чтобы функция запускалась 1 раз. Без этой проверки иногда два раза начисляются очки за моба.
const speed: int = 90
var napravlenie_dvigenia: Vector2 = Vector2.ZERO
var izmenitj_napravlenie_glaz = 0

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var glaza_left: String = "glaza_left"
var glaza_right: String = "glaza_right"

func _ready():
	# Выбираем случайное направление при создании объекта
	var random_number = RandomNumberGenerator.new()
	random_number.randomize() # Инициализируем генератор случайных чисел
	var selected_number = random_number.randi_range(1, 4) 
	
	if selected_number == 1:
		napravlenie_dvigenia = Vector2.UP
		anim.play(glaza_left)
		izmenitj_napravlenie_glaz = 1
	elif selected_number == 2:
		napravlenie_dvigenia = Vector2.DOWN
		anim.play(glaza_left) 
		izmenitj_napravlenie_glaz = 1
	elif selected_number == 3:
		napravlenie_dvigenia = Vector2.LEFT
		anim.play(glaza_left)
		izmenitj_napravlenie_glaz = 1
	elif selected_number == 4:
		napravlenie_dvigenia = Vector2.RIGHT
		anim.play(glaza_right)
		izmenitj_napravlenie_glaz = 2
	
	# Создание пулек, если они включены в глобальной переменной
	if Global.mob_pulki == true:
		# Запускаем таймер на случайное время от 2 до 10 секунд
		var random_time = randf_range(2, 10)
		$Timer.wait_time = random_time
		$Timer.start()
		
func _physics_process(delta):
	if Global.player_death == true:
		napravlenie_dvigenia = Vector2.ZERO
		anim.stop()
	var motion = napravlenie_dvigenia * speed * delta
	var collision = move_and_collide(motion)
	smena_dvigenija_napravlenija() # Функция для случайного изменения направления
		
	# Смена направления при столкновении с каменным или кирпичным блоком
	if collision:
		# Если произошло столкновение, меняем направление
		var random_number = RandomNumberGenerator.new()
		random_number.randomize() # Инициализируем генератор случайных чисел
		var selected_number = random_number.randi_range(1, 4) 
		
		if selected_number == 1:
			napravlenie_dvigenia = Vector2.UP
			if izmenitj_napravlenie_glaz == 1:
				izmenitj_napravlenie_glaz = 2
				anim.play(glaza_right)
			elif izmenitj_napravlenie_glaz == 2:
				izmenitj_napravlenie_glaz = 1
				anim.play(glaza_left)
		elif selected_number == 2:
			napravlenie_dvigenia = Vector2.DOWN
			if izmenitj_napravlenie_glaz == 1:
				izmenitj_napravlenie_glaz = 2
				anim.play(glaza_right)
			elif izmenitj_napravlenie_glaz == 2:
				izmenitj_napravlenie_glaz = 1
				anim.play(glaza_left)
		elif selected_number == 3:
			napravlenie_dvigenia = Vector2.LEFT
			anim.play(glaza_left)
		elif selected_number == 4:
			napravlenie_dvigenia = Vector2.RIGHT
			anim.play(glaza_right)

# Функция для случайного изменения направления
func smena_dvigenija_napravlenija():
	for coord in Global.coordinates_menatj_napravlenie:
		if position.distance_to(coord) < 1: 
			var random_number = RandomNumberGenerator.new()
			random_number.randomize() 
			var selected_number = random_number.randi_range(1, 4) 
		
			if selected_number == 1:
				var random_number2 = RandomNumberGenerator.new()
				random_number.randomize() # Инициализируем генератор случайных чисел
				var selected_number2 = random_number.randi_range(1, 4) 
				
				if selected_number2 == 1:
					napravlenie_dvigenia = Vector2.UP
					if izmenitj_napravlenie_glaz == 1:
						izmenitj_napravlenie_glaz = 2
						anim.play(glaza_right)
					elif izmenitj_napravlenie_glaz == 2:
						izmenitj_napravlenie_glaz = 1
						anim.play(glaza_left)
				elif selected_number2 == 2:
					napravlenie_dvigenia = Vector2.DOWN
					if izmenitj_napravlenie_glaz == 1:
						izmenitj_napravlenie_glaz = 2
						anim.play(glaza_right)
					elif izmenitj_napravlenie_glaz == 2:
						izmenitj_napravlenie_glaz = 1
						anim.play(glaza_left)
				elif selected_number2 == 3:
					napravlenie_dvigenia = Vector2.LEFT
					anim.play(glaza_left)
				elif selected_number2 == 4:
					napravlenie_dvigenia = Vector2.RIGHT
					anim.play(glaza_right)





func destroy():
	if has_destroyed: # Чтобы функция запускалась 1 раз. Без этой проверки иногда два раза начисляются очки за моба.
		return
	has_destroyed = true
	var new_object = load("res://Mobs/Mob_shar/Mob_shar_death/mob_shar_death.tscn").instantiate()
	new_object.global_position = global_position
	get_parent().add_child(new_object)
	queue_free()
	Global.massiv_vse_sozdannie_mobi.erase(self) # Удаляю из глобального массива моба, который был уничтожен
	
	
	
# Когда таймер истекает, запускается пулька
func _on_timer_timeout():
	if Global.mob_pulki == true:
		var new_pulka = pulka.instantiate()
		get_parent().add_child(new_pulka)
		new_pulka.global_position = global_position
		
func _on_area_2d_body_entered(player):
	if player.has_method("destroy") and not player.has_been_destroyed:
		player.destroy()
