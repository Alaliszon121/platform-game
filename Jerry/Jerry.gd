extends KinematicBody2D

var velocity = Vector2(0, 0)
const SPEED = 400
const GRAVITY = 50
const JUMPFORCE = -1300

signal damaged

func _physics_process(_delta):
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

func _on_Area2D_body_entered(_body):
	get_tree().change_scene("res://Level_1/Level1.tscn")

func bounce():
	velocity.y = JUMPFORCE * 0.7

func damaged(var _posx):
	set_modulate(Color(1,0.3,0.3,0.7))
	$Timer.start()
	set_collision_mask_bit(4, false)
	velocity.y = JUMPFORCE * 0.5
	emit_signal("damaged")

func _on_Timer_timeout():
	set_modulate(Color(1,1,1,1))
	set_collision_mask_bit(4, true)
