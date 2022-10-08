extends KinematicBody2D

var velocity = Vector2(0, 0)
const SPEED = 400
const GRAVITY = 50
const JUMPFORCE = -1300

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = true
	else:
		$Sprite.play("idle")
	
	if  not is_on_floor():
		$Sprite.play("jump")
	
	velocity.y = velocity.y + GRAVITY
	
	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y = JUMPFORCE
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.x = lerp(velocity.x, 0, 0.2)
	

func _on_Area2D_body_entered(body):
	get_tree().change_scene("res://Level1.tscn")

