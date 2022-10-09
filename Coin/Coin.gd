extends Area2D

signal coin_collected

func _on_Coin_body_entered(_body):
	emit_signal("coin_collected")
	set_collision_mask_bit(0, false)
	queue_free()
