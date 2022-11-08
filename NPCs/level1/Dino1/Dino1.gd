extends KinematicBody2D

signal dialogue_start

func _on_Area2D_body_entered(body):
	if !PlayerData.is_dialog_playing:
		emit_signal("dialogue_start")
		PlayerData.is_dialog_playing = true
		$mark.queue_free()
		var new_dialog = Dialogic.start('Dino1')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, 'dino_gone')

func dino_gone(_timeline_name):
	$Timer.start()

func _on_Timer_timeout():
	PlayerData.is_dialog_playing = false
	get_tree().change_scene("res://Winner_scene.tscn")



