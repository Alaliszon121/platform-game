extends Node2D

func _ready():
	$Jerry/Wings.visible = false

func _on_wings_checker_should_have_wings(jerry, checker_position):
	#jerry.should_have_wings = !jerry.should_have_wings
	if jerry.position.x > checker_position and jerry.direction == 1:
		$Jerry/Wings.visible = true
		jerry.should_have_wings = true
		#jerry.$Sprite.flip_h = false
	elif jerry.direction == -1:
		$Jerry/Wings.visible = false
		jerry.should_have_wings = false

func _on_rock_checker_body_entered(body):
	#Input.action_release("ui_right")
	$Jerry.set_modulate(Color(1,0.3,0.3,0.7))
	$Jerry/Timer.start()
	$Jerry.set_collision_mask_bit(4, false)
	$Jerry.velocity.y = $Jerry.JUMPFORCE * 0.5
	
	if body.position.x < $Jerry.position.x:
		$Jerry.velocity.x = -1800
	elif position.x > $Jerry.position.x:
		$Jerry.velocity.x = 1800
	
	$Jerry.emit_signal("damaged")

func _on_checker_body_entered(body, extra_arg_0):
	if $Jerry.should_have_wings:
		$Jerry.set_modulate(Color(1,0.3,0.3,0.7))
		$Jerry/Timer.start()
		if extra_arg_0 == 1:
			extra_arg_0 -= 0.5
		$Jerry.velocity.y = 1000 * extra_arg_0
		$Jerry.emit_signal("damaged")
