extends Control

func _ready():
	var eastereggs = PlayerData.coins
	var enemies = PlayerData.enemies_killed
	$Panel/Coins.text = "You've collected " + String(eastereggs) + " out of 28 easteregg(s)."
	$Panel/Enemies.text = "You've killed " + String(enemies) + " enemies."

func _on_TryAgain_pressed():
	get_tree().change_scene("res://Level_1/Level1.tscn")

func _on_goToMenu_pressed():
	get_tree().change_scene("res://Start_scene.tscn")
