extends Area2D

func _on_Area2D_body_entered(body):
	body.velocity.y = 0
	body.position.x = 1150
	body.position.y = 0
