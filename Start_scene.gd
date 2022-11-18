extends Control

func _on_new_game_button_pressed():
	get_tree().change_scene("res://Level_1/Level1.tscn")

func _on_see_levels_button_pressed():
	get_tree().change_scene("res://Levels/Choose_level.tscn")
