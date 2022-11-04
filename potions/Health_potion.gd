extends Area2D

signal health_gained

func _on_Health_potion_body_entered(_body):
	emit_signal("health_gained")
	queue_free()
