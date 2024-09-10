extends StaticBody2D

var speed = 3000 # Скорость распространения лазера
var max_distance: int = Global.dlina_lazera # Длина лазера в пикселях. Для длины в 1 клетку - 48px. 2 клетки - 96px
var current_distance = 0

func _physics_process(delta):
	var direction = Vector2.UP  
	var distance = speed * delta  
	if current_distance + distance > max_distance:
		distance = max_distance - current_distance
		queue_free()
	var collision = move_and_collide(direction * distance)
	if collision:
		speed = 0
		var collider = collision.get_collider()
		if collider.has_method("destroy"):
			collider.destroy()
		queue_free()	
	current_distance += distance
