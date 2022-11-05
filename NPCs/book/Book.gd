extends KinematicBody2D

signal dialogue_start
signal dialogue_end

func _ready():
	PlayerData.is_dialog_playing = true
	var new_dialog = Dialogic.start('Book1')
	add_child(new_dialog)
	emit_signal("dialogue_start")
	new_dialog.connect("timeline_end", self, 'book_gone')

func book_gone(_timeline_name):
	emit_signal("dialogue_end")
	$Sprite.visible = false
	$CollisionShape2D.disabled = true
	PlayerData.is_dialog_playing = false
