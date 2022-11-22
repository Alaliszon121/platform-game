extends StaticBody2D

var active_dialog

signal dialogue_start
signal dialogue_end

func _ready():
	active_dialog = true

func _on_Area2D_body_entered(body):
	print(body)
	if not PlayerData.is_dialog_playing and active_dialog:
		PlayerData.is_dialog_playing = true
		var new_dialog = Dialogic.start(name)
		add_child(new_dialog)
		emit_signal("dialogue_start")
		new_dialog.connect("timeline_end", self, 'sign_gone')
		active_dialog = false

func sign_gone(_timeline_name):
	emit_signal("dialogue_end")
	PlayerData.is_dialog_playing = false
