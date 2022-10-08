extends Area2D

signal coin_collected

onready var animationPlayer = $AnimationPlayer

# warning-ignore:unused_argument
func _on_Coin_body_entered(body):
	queue_free()
