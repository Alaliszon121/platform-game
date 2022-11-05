extends KinematicBody2D

enum States {AIR, FLOOR, DIALOGUE, LADDER}

var state = States.AIR
var velocity = Vector2(0, 0)

var jumps_left = 0

var last_walljump_direction = 0
var direction = 1

const SPEED = 400
const GRAVITY = 50
const JUMPFORCE = -1300

signal damaged

func _physics_process(_delta):
	print(jumps_left)
	match state:
		States.AIR:
			if is_on_floor():
				state = States.FLOOR
				continue
			elif can_walljump():
				if Input.is_action_pressed("ui_up") and ((Input.is_action_pressed("ui_left") and direction == 1) or (Input.is_action_pressed("ui_right") and direction == -1)):
					last_walljump_direction = direction
					velocity.y = JUMPFORCE
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
				velocity.y = JUMPFORCE
				jumps_left = 0
			set_direction()
			move_and_fall()
			
		States.FLOOR:
			last_walljump_direction = 0
			if not is_on_floor():
				jumps_left = 1
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
