extends Node2D

func _ready():
	$Jerry/Wings.visible = false

func _on_wings_checker_body_entered(body):
	body.should_have_wings = !body.should_have_wings
	if body.should_have_wings:
		$Jerry/Wings.visible = true
		#body.$Sprite.flip_h = false
	else:
		$Jerry/Wings.visible = false
