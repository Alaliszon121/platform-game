extends KinematicBody2D

var velocity = Vector2(0, 0)
var speed = 150
enum States {SLEEP, FLY}
var state = States.SLEEP

func _physics_process(_delta):
	match state:
		States.SLEEP:
			continue
		States.FLY:
			$AnimatedSprite.play("default")
			velocity.x = -speed
			velocity = move_and_slide(velocity, Vector2.UP)

func _on_sides_checker_body_entered(body):
	$sides_checker.set_collision_mask_bit(0, false)
	$Immortality_timer.start()
	body.damaged(position.x)

func _on_Immortality_timer_timeout():
	queue_free()

func _on_player_checker_body_entered(_body):
	$Timer.start()
	$player_checker.queue_free()
	state = States.FLY

func _on_Timer_timeout():
	queue_free()
