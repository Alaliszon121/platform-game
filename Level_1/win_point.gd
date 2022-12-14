extends Area2D

signal hide_mark

func _on_win_point_body_entered(body):
	if !PlayerData.is_dialog_playing:
		PlayerData.is_dialog_playing = true
		emit_signal("hide_mark")
		var new_dialog = Dialogic.start('Dino1')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, 'dino_gone')

func dino_gone(_timeline_name):
	$Timer.start()

func _on_Timer_timeout():
	PlayerData.is_dialog_playing = false
	get_tree().change_scene("res://Winner_scene.tscn")

