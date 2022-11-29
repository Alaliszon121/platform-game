extends StaticBody2D

signal dialogue_start
signal dialogue_end

signal stop_fire_timer
signal start_fire_timer

signal open_trapwall

func _on_Area2D_body_entered(_body):
	if not PlayerData.is_dialog_playing:
		PlayerData.is_dialog_playing = true
		var new_dialog = Dialogic.start(name)
		add_child(new_dialog)
		emit_signal("stop_fire_timer")
		emit_signal("dialogue_start")
		new_dialog.connect("timeline_end", self, 'dialog_ended')

func dialog_ended(_timeline_name):
	if Dialogic.get_variable('first_time_talked_to_caveman') == "true":
		Dialogic.set_variable('first_time_talked_to_caveman', "false")
	emit_signal("start_fire_timer")
	emit_signal("dialogue_end")
	if Dialogic.get_variable('is_caveman_happy') == "true":
		$Area2D.queue_free()
		$mark.queue_free()
		emit_signal("open_trapwall")
	PlayerData.is_dialog_playing = false

func _has_fire():
	Dialogic.set_variable('is_player_has_fire', "true")

func _lost_fire():
	Dialogic.set_variable('is_player_has_fire', "false")
