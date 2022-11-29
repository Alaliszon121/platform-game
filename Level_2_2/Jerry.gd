extends Node2D

func _ready():
	$Jerry/Wings.visible = false

func _on_wings_checker_body_entered(body):
	$Jerry/Wings.visible = true
