extends CanvasLayer

var hearts = 3

func _on_Jerry_damaged():
	if hearts > 1:
		hearts = hearts - 1
		if $heart3.visible:
			$heart3.visible = false
		elif $heart2.visible:
			$heart2.visible = false
	elif hearts == 1:
		$heart.visible = false
		$Timer.start()

func _on_Timer_timeout():
	get_tree().reload_current_scene()

func _on_Health_potion_health_gained():
	if hearts < 3:
		hearts = hearts + 1
		
	if $heart2.visible == false:
		$heart2.visible = true
	elif $heart3.visible == false:
		$heart3.visible = true
	else:
		pass
