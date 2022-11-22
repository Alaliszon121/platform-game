extends "res://enemy/level1_2/tiger.gd"

var lives = 9

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

func _on_top_checker_body_entered(body):
	if lives > 1:
		body.bounce()
		lives = lives - 1
		$AnimatedSprite.play("dead")
		speed = 0
		$Immortality_timer.start()
	else:
		._on_top_checker_body_entered(body)

func _on_Immortality_timer_timeout():
	speed = 200
	$AnimatedSprite.play("default")
	._on_Immortality_timer_timeout()
