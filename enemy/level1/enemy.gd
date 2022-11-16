extends KinematicBody2D

var velocity = Vector2(0, 0)
const GRAVITY = 20
export var direction = -1
var speed = 70

func _ready():
	PlayerData.enemies_killed = 0
	if direction == -1:
		$AnimatedSprite.flip_h = true
	$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction

func _physics_process(_delta):
	if is_on_wall() or not $floor_checker.is_colliding() and is_on_floor():
		direction = direction * -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
		
	velocity.y = velocity.y + GRAVITY
	velocity.x = speed * direction
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_top_checker_body_entered(body):
	$sides_checker.set_collision_mask_bit(0, false)
	$AnimatedSprite.play("dead")
	speed = 0
	set_collision_layer_bit(4, false)
	set_collision_mask_bit(0, false)
	$top_checker.set_collision_mask_bit(0, false)
	$Timer.start()
	body.bounce()

func _on_sides_checker_body_entered(body):
	$top_checker.set_collision_mask_bit(0, false)
	$sides_checker.set_collision_mask_bit(0, false)
	$Immortality_timer.start()
	body.damaged(position.x)

func _on_Timer_timeout():
	PlayerData.enemies_killed = PlayerData.enemies_killed + 1
	queue_free()

func _on_Immortality_timer_timeout():
	$top_checker.set_collision_mask_bit(0, true)
	$sides_checker.set_collision_mask_bit(0, true)
