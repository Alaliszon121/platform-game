extends KinematicBody2D

var active_dialog = true

func _on_Area2D_body_entered(body):
	print("czytam!")
	if !PlayerData.is_dialog_playing and active_dialog:
		PlayerData.is_dialog_playing = true
		var new_dialog = Dialogic.start('Sign1')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, 'sign_gone')
		$mark.queue_free()
		active_dialog = false

func sign_gone(_timeline_name):
	PlayerData.is_dialog_playing = false
