extends Area2D

signal should_have_wings

func _on_wings_checker_body_entered(body):
	emit_signal("should_have_wings", body, $CollisionShape2D.position.x)
