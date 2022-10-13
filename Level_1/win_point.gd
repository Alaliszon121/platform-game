extends Area2D

func _on_win_point_body_entered(body):
	$Timer.start()
	if Input.is_action_pressed("ui_right"):
		body.get_node("Sprite").play("won")
	elif Input.is_action_pressed("ui_left"):
		body.get_node("Sprite").play("won")
	else:
		body.get_node("Sprite").play("won")
		
	if  not body.is_on_floor():
		body.get_node("Sprite").play("won")

func _on_Timer_timeout():
	get_tree().change_scene("res://Winner_scene.tscn")
