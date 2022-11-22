extends Node2D

var can_go_down := false

func _physics_process(_delta):
	if can_go_down and Input.is_action_pressed("ui_down"):
		$CollisionShape2D.rotation_degrees = 180
	else:
		$CollisionShape2D.rotation_degrees = 0


func _on_Area2D_body_entered(_body):
	can_go_down = true


func _on_Area2D_body_exited(_body):
	can_go_down = false

