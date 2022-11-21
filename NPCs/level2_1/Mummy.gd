extends StaticBody2D

var active_dialog := true

signal dialogue_start
signal dialogue_end
signal open_trapwall
signal show_pieces_counter

func _ready():
	active_dialog = true

func _on_Area2D_body_entered(body):
	if not PlayerData.is_dialog_playing and active_dialog:
		PlayerData.is_dialog_playing = true
		var new_dialog = Dialogic.start(name)
		add_child(new_dialog)
		emit_signal("dialogue_start")
		new_dialog.connect("timeline_end", self, 'sign_gone')
		$mark.visible = false
		active_dialog = false

func sign_gone(_timeline_name):
	emit_signal("dialogue_end")
	PlayerData.is_dialog_playing = false
	emit_signal("show_pieces_counter")
	$Timer.start()

func _on_Timer_timeout():
	$mark.visible = true
	active_dialog = true

func _on_HUDCounter_pieces_collected():
	Dialogic.set_variable('is_sarcophagus_repaired', "true")
	emit_signal("open_trapwall")
