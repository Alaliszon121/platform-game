extends KinematicBody2D

enum States {AIR, FLOOR, DIALOGUE, LADDER, FLY}

var state = States.AIR
var velocity = Vector2(0, 0)

var jumps_left = 0

var last_walljump_direction = 0
var direction = 1
var slow = 1

var on_ladder := false

const SPEED = 400
const GRAVITY = 50
const JUMPFORCE = -1300

signal damaged

func _physics_process(_delta):
	match state:
		States.AIR:
			if is_on_floor():
				state = States.FLOOR
				continue
			elif can_walljump():
				if Input.is_action_pressed("ui_up") and ((Input.is_action_pressed("ui_left") and direction == 1) or (Input.is_action_pressed("ui_right") and direction == -1)):
					last_walljump_direction = direction
					velocity.y = JUMPFORCE
			elif can_climb():
				state = States.LADDER
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
			if jumps_left == 1 and Input.is_action_pressed("ui_up"):
				velocity.y = JUMPFORCE * slow
				jumps_left = 0
			set_direction()
			move_and_fall()
			
		States.FLOOR:
			last_walljump_direction = 0
			if not is_on_floor():
				jumps_left = 1
				state = States.AIR
				continue
			elif can_climb():
				state = States.LADDER
				continue
			if Input.is_action_pressed("ui_right"):
				velocity.x = SPEED * slow
				$Sprite.play("walk")
				$Sprite.flip_h = false
			elif Input.is_action_pressed("ui_left"):
				velocity.x = -SPEED * slow
				$Sprite.play("walk")
				$Sprite.flip_h = true
			else:
				$Sprite.play("idle")
				velocity.x = lerp(velocity.x, 0, 0.2)
			if Input.is_action_pressed("ui_up"):
				velocity.y = JUMPFORCE * slow
				state = States.AIR
			set_direction()
			move_and_fall()
			
		States.DIALOGUE:
			$Sprite.play("idle")
			if Input.is_action_pressed("ui_right"):
				$Sprite.flip_h = false
			elif Input.is_action_pressed("ui_left"):
				$Sprite.flip_h = true
			velocity.x = lerp(velocity.x, 0, 0.2)
			move_and_fall()
			
		States.LADDER:
			if not on_ladder:
				state = States.AIR
			elif is_on_floor() and Input.is_action_pressed("ui_down"):
				Input.action_release("ui_down")
				Input.action_release("ui_up")
				state = States.FLOOR
			
			if Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down"):
				$Sprite.play("climb")
				$Sprite.playing = true
			else:
				$Sprite.playing = false
			
			if Input.is_action_pressed("ui_up"):
				velocity.y = -SPEED * 0.8
				velocity.x = 0
			elif Input.is_action_pressed("ui_down"):
				velocity.y = SPEED * 0.8
				velocity.x = 0
			else:
				velocity.y = lerp(velocity.y, 0, 0.3)
			
			if Input.is_action_pressed("ui_right"):
				velocity.x = SPEED * 0.5
			elif Input.is_action_pressed("ui_left"):
				velocity.x = -SPEED * 0.5
			velocity = move_and_slide(velocity, Vector2.UP)
		
		States.FLY:
			$Sprite.play("jump")
			if Input.is_action_pressed("ui_right"):
				velocity.x = SPEED
				$Sprite.flip_h = false
				$Wings.flip_h = false
				$Wings.position.x = -49
			elif Input.is_action_pressed("ui_left"):
				velocity.x = -SPEED
				$Sprite.flip_h = true
				$Wings.flip_h = true
				$Wings.position.x = 55
			else:
				velocity.x = lerp(velocity.x, 0, 0.2)
			if Input.is_action_just_pressed("ui_up"):
				#set_animation_loop("fly", false)
				$Wings.play("fly")
				velocity.y = JUMPFORCE
			set_direction()
			move_and_fall()

func can_climb():
	if on_ladder and (Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down")):
		return true
	else:
		return false

func can_walljump():
	if is_near_wall() and (jumps_left == 0) and (last_walljump_direction != direction):
		if $Wallchecker.rotation_degrees == 90:
			last_walljump_direction = 1
		elif $Wallchecker.rotation_degrees == -90:
			last_walljump_direction = -1
		return true
	else:
		return false

func is_near_wall():
	return $Wallchecker.is_colliding()

func set_direction():
	if $Sprite.flip_h:
		direction = -1
	else:
		direction = 1
	$Wallchecker.rotation_degrees = 90 * -direction

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

func _on_NPC_dialogue_start():
	state = States.DIALOGUE

func _on_NPC_dialogue_end():
	state = States.FLOOR

func _on_LadderChecker_body_entered(_body):
	on_ladder = true

func _on_LadderChecker_body_exited(_body):
	on_ladder = false

func _on_sand_checker_body_entered(_body):
	slow = 0.3

func _on_sand_checker_body_exited(_body):
	slow = 1

func snake_jump():
	jumps_left = 1
	velocity.y = JUMPFORCE * 1.2

func _on_wings_checker_body_entered(body):
	state = States.FLY
