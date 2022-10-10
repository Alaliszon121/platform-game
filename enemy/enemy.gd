extends KinematicBody2D

var velocity = Vector2(0, 0)
const GRAVITY = 20
export var direction = -1

func _ready():
	if direction == -1:
		$AnimatedSprite.flip_h = true
	$floor_checker.position.x = $CollisionPolygon2D.shape.get_extends().x * direction

func _physics_process(_delta):
	if is_on_wall():
		direction = direction * -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
	
	velocity.y = velocity.y + GRAVITY
	
	velocity.x = 70 * direction
	
	velocity = move_and_slide(velocity, Vector2.UP)
