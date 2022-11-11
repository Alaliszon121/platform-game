extends KinematicBody2D

var velocity = Vector2(0, 0)
const GRAVITY = 30
enum States {SLEEP, FALL}
var state
export var direction = 1

func _ready():
	state = States.SLEEP
	if direction == -1:
		$Sprite.flip_v = true
		$CollisionPolygon2D.rotation_degrees = $CollisionPolygon2D.rotation_degrees + 180
		$CollisionPolygon2D.position.y = $CollisionPolygon2D.position.y + 48
		$damage_checker.position.y = $damage_checker.position.y - 56
		$player_checker.queue_free()

func _physics_process(_delta):
	match state:
		States.SLEEP:
			continue
		States.FALL:
			velocity.y = velocity.y + GRAVITY
			velocity = move_and_slide(velocity, Vector2.UP)

func _on_player_checker_body_entered(body):
	$player_checker.set_collision_mask_bit(0, false)
	state = States.FALL

func _on_damage_checker_body_entered(body):
	$damage_checker.set_collision_mask_bit(0, false)
	$Timer.start()
	body.damaged(position.x)

func _on_Timer_timeout():
	queue_free()
