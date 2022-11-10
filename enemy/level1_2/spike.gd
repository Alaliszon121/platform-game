extends KinematicBody2D

var velocity = Vector2(0, 0)
const GRAVITY = 30

enum States {SLEEP, FALL}
var state

func _physics_process(_delta):
	match state:
		States.SLEEP:
			continue
		States.FALL:
			velocity.y = velocity.y + GRAVITY
			velocity = move_and_slide(velocity, Vector2.UP)

func _on_player_checker_body_entered(body):
	state = States.FALL

func _on_Timer_timeout():
	queue_free()
