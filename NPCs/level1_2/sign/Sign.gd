extends StaticBody2D

var active_dialog = true
signal dialogue_start
signal dialogue_end

func _on_Area2D_body_entered(_body):
	if !PlayerData.is_dialog_playing and active_dialog:
		PlayerData.is_dialog_playing = true
		var new_dialog = Dialogic.start('Sign2')
		add_child(new_dialog)
		emit_signal("dialogue_start")
		new_dialog.connect("timeline_end", self, 'sign_gone')
		$mark.queue_free()
		active_dialog = false

func sign_gone(_timeline_name):
	emit_signal("dialogue_end")
	PlayerData.is_dialog_playing = false

