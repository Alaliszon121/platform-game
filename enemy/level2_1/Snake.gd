extends KinematicBody2D

var velocity = Vector2(0, 0)
const GRAVITY = 20
export var direction = -1
var speed = 100

func _ready():
	if direction == 1:
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
	jump_animation()
	body.snake_jump()

func jump_animation():
	$AnimationPlayer.play("Bounce")
