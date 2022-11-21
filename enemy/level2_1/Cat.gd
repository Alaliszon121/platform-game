extends "res://enemy/level1_2/tiger.gd"

func _ready():
	._ready()
	speed = 200

func _on_player_target_body_entered(body):
	if body.position.x > position.x:
		if direction == -1:
			$AnimatedSprite.flip_h = false
			direction = direction * -1
	elif body.position.x < position.x:
		if direction == 1:
			$AnimatedSprite.flip_h = true
			direction = direction * -1
	$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction

