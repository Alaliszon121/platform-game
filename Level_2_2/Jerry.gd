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
		#jerry/$Wings.visible = false
		jerry.should_have_wings = false
