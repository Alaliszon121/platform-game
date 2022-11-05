extends Control

func _ready():
	var eastereggs = PlayerData.coins
	var enemies = PlayerData.enemies_killed
	$Panel/MenuButton.get_popup().add_item("You've collected " + String(eastereggs) + " out of 28 easteregg(s).")
	$Panel/MenuButton.get_popup().add_item("You've killed " + String(enemies) + " enemies.")

func _on_LinkButton_pressed():
	get_tree().change_scene("res://Level_1/Level1.tscn")
