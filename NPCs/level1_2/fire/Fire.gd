extends AnimatedSprite

var can_be_played := true

signal dialogue_start
signal dialogue_end

signal fire_collected

func _on_Area2D_body_entered(body):
	if not PlayerData.is_dialog_playing and can_be_played:
		PlayerData.is_dialog_playing = true
		var new_dialog = Dialogic.start(name)
		add_child(new_dialog)
		emit_signal("dialogue_start")
		new_dialog.connect("timeline_end", self, 'dialog_ended')
	if !can_be_played:
		emit_signal("fire_collected")

func dialog_ended(_timeline_name):
	if can_be_played:
		can_be_played = false
	emit_signal("dialogue_end")
	PlayerData.is_dialog_playing = false
	emit_signal("fire_collected")
