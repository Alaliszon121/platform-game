extends Control

var coins_array = [0, 0, 0, 0, 0]
var passed_level_array = [true, false, false, false, false]
var counter = 0

func _ready():
	load_game()
	$Panel_level1/coins.text = var2str(coins_array[0])
	$Panel_level2/coins.text = var2str(coins_array[1])
	$Panel_level3/coins.text = var2str(coins_array[2])
	$Panel_level4/coins.text = var2str(coins_array[3])
	$Panel_level5/coins.text = var2str(coins_array[4])
	if passed_level_array[0]:
		$Panel_level1/level1.disabled = false

func _on_level1_pressed():
	get_tree().change_scene("res://Level_1/Level1.tscn")

func _on_Back_pressed():
	get_tree().change_scene("res://Start_scene.tscn")

func load_game():
	var file = File.new()
	if file.file_exists(ProjectSettings.globalize_path(PlayerData.SAVE_PATH)):
		file.open(PlayerData.SAVE_PATH, File.READ)
		var save_dict = parse_json(file.get_line())
		coins_array[0] = str2var(save_dict.level1.coins)
		passed_level_array[0] = str2var(save_dict.level1.level_passed)
