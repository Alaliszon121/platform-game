extends Node2D

func _on_Area2D_body_exited(body):
	$Jerry/Light2D.enabled = true
	$CanvasModulate.visible = true
