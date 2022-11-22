extends Node2D


func _on_Area2D_body_exited(_body):
	$Jerry/Light2D.enabled = true
	$CanvasModulate.visible = true

func _on_Mummy_open_trapwall():
	$StaticNodes/Wallblock.queue_free()
	$StaticNodes/Sarcophagus7.visible = true
