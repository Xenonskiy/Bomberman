extends StaticBody2D

func _ready():
	if Global.vzal_item_knopka == false:
		$Timer.start()

func _on_timer_timeout():
	if Global.vzal_item_knopka == false:
		queue_free()

func _process(delta):
	if Global.vzal_item_knopka == true and Global.player_voshel_v_vorota == false:
		if Input.is_action_pressed("ui_key_B_player_2"):
			queue_free()
