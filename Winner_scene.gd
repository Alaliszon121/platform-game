extends Control

func _ready():
	var file = File.new()
	file.open(PlayerData.SAVE_PATH, File.READ)
	var save_data = parse_json(file.get_line())
	var eastereggs = str2var(save_data.coins_level_1) + str2var(save_data.coins_level_1_2)
	var enemies = PlayerData.enemies_killed
	$Panel/Coins.text = "You've collected " + String(eastereggs) + " out of 50 collectibles."
	$Panel/Enemies.text = "You've killed " + String(enemies) + " enemies."

func _on_TryAgain_pressed():
	get_tree().change_scene("res://Level_1/Level1.tscn")

func _on_goToMenu_pressed():
	get_tree().change_scene("res://Start_scene.tscn")
