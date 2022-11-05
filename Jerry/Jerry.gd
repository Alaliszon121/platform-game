extends KinematicBody2D

enum States {AIR, FLOOR, DIALOGUE, LADDER, WALL}
var state = States.AIR
var velocity = Vector2(0, 0)
const SPEED = 400
const GRAVITY = 50
const JUMPFORCE = -1300
var can_jump = false

signal damaged

func _physics_process(_delta):
	match state:
		States.AIR:
			if is_on_floor():
				state = States.FLOOR
				continue
			$Sprite.play("jump")
			if Input.is_action_pressed("ui_right"):
				velocity.x = SPEED
				$Sprite.flip_h = false
			elif Input.is_action_pressed("ui_left"):
				velocity.x = -SPEED
				$Sprite.flip_h = true
			else:
				velocity.x = lerp(velocity.x, 0, 0.2)
			if can_jump and Input.is_action_just_pressed("ui_up"):
				velocity.y = JUMPFORCE
			move_and_fall()
			
		States.FLOOR:
			if not is_on_floor():
				can_jump = true
				$CoyoteTimer.start()
				state = States.AIR
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
				velocity.x = lerp(velocity.x, 0, 0.2)
			if Input.is_action_pressed("ui_up"):
				velocity.y = JUMPFORCE
				state = States.AIR
				
			move_and_fall()
			
		States.WALL:
			pass
			
		States.DIALOGUE:
			$Sprite.play("idle")
			if Input.is_action_pressed("ui_right"):
				$Sprite.flip_h = false
			elif Input.is_action_pressed("ui_left"):
				$Sprite.flip_h = true
			velocity.x = lerp(velocity.x, 0, 0.2)
			move_and_fall()

func is_near_wall():
	pass

func move_and_fall():
	velocity.y = velocity.y + GRAVITY
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_Area2D_body_entered(_body):
	get_tree().change_scene("res://Level_1/Level1.tscn")

func bounce():
	velocity.y = JUMPFORCE * 0.7

func damaged(var posx):
	set_modulate(Color(1,0.3,0.3,0.7))
	$Timer.start()
	set_collision_mask_bit(4, false)
	velocity.y = JUMPFORCE * 0.5
	
	if position.x < posx:
		velocity.x = -800
	elif position.x > posx:
		velocity.x = 800
	
	emit_signal("damaged")

func _on_Timer_timeout():
	set_modulate(Color(1,1,1,1))
	set_collision_mask_bit(4, true)

func _on_CoyoteTimer_timeout():
	can_jump = false

func _on_NPC_dialogue_start():
	state = States.DIALOGUE

func _on_NPC_dialogue_end():
	state = States.FLOOR
