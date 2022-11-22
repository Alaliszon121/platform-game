extends Area2D

signal pieces_collected

func _on_Sarcophagus_body_entered(_body):
	print("zebrane")
	emit_signal("pieces_collected")
	queue_free()
