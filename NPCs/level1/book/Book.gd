extends KinematicBody2D

signal dialogue_start
signal dialogue_end

func _ready():
	if !PlayerData.is_dialogue_book_played:
		PlayerData.is_dialogue_book_played = true
		PlayerData.is_dialog_playing = true
		var new_dialog = Dialogic.start('Book1')
		add_child(new_dialog)
		emit_signal("dialogue_start")
		new_dialog.connect("timeline_end", self, 'book_gone')
	else:
		queue_free()

func book_gone(_timeline_name):
	emit_signal("dialogue_end")
	PlayerData.is_dialog_playing = false
	queue_free()
