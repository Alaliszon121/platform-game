extends KinematicBody2D

func _ready():
	PlayerData.is_dialog_playing = true
	var new_dialog = Dialogic.start('Book1')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, 'book_gone')

func book_gone(_timeline_name):
	$Sprite.visible = false
	$CollisionShape2D.disabled = true
	PlayerData.is_dialog_playing = false
