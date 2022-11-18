extends KinematicBody2D

signal dialogue_start
signal dialogue_end

var first_time_dialog_played := true

func _on_Area2D_body_entered(body):
	if !PlayerData.is_dialog_playing and first_time_dialog_played:
		emit_signal("dialogue_start")
		PlayerData.is_dialog_playing = true
		$mark.queue_free()
		var new_dialog = Dialogic.start('Dino1')
		add_child(new_dialog)
		first_time_dialog_played = false
		new_dialog.connect("timeline_end", self, 'dino_gone')

func dino_gone(_timeline_name):
	emit_signal("dialogue_end")
	PlayerData.is_dialog_playing = false
	PlayerData.is_dialogue_book_played = false
	$Timer.start()

func _on_Timer_timeout():
	PlayerData.is_dialog_playing = false

