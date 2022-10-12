extends CanvasLayer

func _on_Jerry_damaged():
	if get_node("heart3") != null:
		$heart3.queue_free()
	elif get_node("heart2") != null:
		$heart2.queue_free()
	else:
		$Timer.start()

func _on_Timer_timeout():
	get_tree().change_scene("res://Level1.tscn")
