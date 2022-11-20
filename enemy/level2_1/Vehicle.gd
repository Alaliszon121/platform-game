extends KinematicBody2D

var velocity = Vector2(0, 0)
const GRAVITY = 10
var slow = 1
var slowed = 1
enum States {SLEEP, FALL}
var state

func _ready():
	state = States.SLEEP

func _physics_process(_delta):
	print(slowed)
	match state:
		States.SLEEP:
			continue
		States.FALL:
			velocity.y = (velocity.y + GRAVITY) * slow
			velocity = move_and_slide(velocity, Vector2.UP) * slow

func _on_player_checker_body_entered(body):
	$player_checker.queue_free()
	state = States.FALL

func _on_damage_checker_body_entered(body):
	$damage_checker.set_collision_mask_bit(0, false)
	$damage_checker.queue_free()
	$Timer.start()
	body.damaged(position.x)

func _on_Timer_timeout():
	queue_free()

func _on_sand_checker_body_entered(body):
	slow = 0.8
	$damage_checker.queue_free()
	$slow_animation.start()

func _on_slow_animation_timeout():
	slowed = slowed * slow
	$AnimatedSprite.set_speed_scale(slowed)
