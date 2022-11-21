extends CanvasLayer

signal pieces_collected
var pieces = 0

func _ready():
	$Panel/Coins.text = String(pieces)

func _on_Mummy_show_pieces_counter():
	visible = true

func _on_Sarcophagus_pieces_collected():
	print("wyświetlone")
	pieces = pieces + 1
	if pieces == 6:
		emit_signal("pieces_collected")
	$Panel/Coins.text = String(pieces)
