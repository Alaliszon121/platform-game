extends Control

var coins_array = [0, 0, 0, 0, 0]
var unlocked_levels = 0
var counter = 0
onready var levels_path = [$Panel_level1/level1, $Panel_level2/level2, $Panel_level3/level3, $Panel_level4/level4, $Panel_level5/level5]

func _ready():
	load_game()
	$Panel_level1/coins.text = var2str(coins_array[0]) + "/50"
	$Panel_level2/coins.text = var2str(coins_array[1]) + "/50"
	$Panel_level3/coins.text = var2str(coins_array[2]) + "/50"
	$Panel_level4/coins.text = var2str(coins_array[3]) + "/50"
	$Panel_level5/coins.text = var2str(coins_array[4]) + "/50"
	for i in unlocked_levels:
		levels_path[i].disabled = false
	#	$Panel_level1/level1.disabled = false

func _on_level1_pressed():
	get_tree().change_scene("res://Levels/Level1.tscn")

func _on_level2_pressed():
	get_tree().change_scene("res://Levels/Level2.tscn")

func _on_level3_pressed():
	get_tree().change_scene("res://Levels/Choose_level.tscn")

func _on_level4_pressed():
	get_tree().change_scene("res://Levels/Choose_level.tscn")

func _on_level5_pressed():
	get_tree().change_scene("res://Levels/Choose_level.tscn")

func _on_Back_pressed():
	get_tree().change_scene("res://Start_scene.tscn")

func load_game():
	var file = File.new()
	if file.file_exists(ProjectSettings.globalize_path(PlayerData.SAVE_PATH)):
		file.open(PlayerData.SAVE_PATH, File.READ)
		var save_data = parse_json(file.get_line())
		unlocked_levels = str2var(save_data.number_of_unlocked_levels)
		coins_array[0] = str2var(save_data.coins_level_1) + str2var(save_data.coins_level_1_2)
		coins_array[1] = str2var(save_data.coins_level_2_1) + str2var(save_data.coins_level_2_2) + str2var(save_data.coins_level_2_3)
		coins_array[2] = str2var(save_data.coins_level_3_1) + str2var(save_data.coins_level_3_2) + str2var(save_data.coins_level_3_3) + str2var(save_data.coins_level_3_4)
		coins_array[3] = str2var(save_data.coins_level_4_1) + str2var(save_data.coins_level_4_2) + str2var(save_data.coins_level_4_3)
		coins_array[4] = str2var(save_data.coins_level_5_1) + str2var(save_data.coins_level_5_2) + str2var(save_data.coins_level_5_3)
	#var file = File.new()
	#if file.file_exists(ProjectSettings.globalize_path(PlayerData.SAVE_PATH)):
	#	file.open(PlayerData.SAVE_PATH, File.READ)
	#	var save_dict = parse_json(file.get_line())
	#	coins_array[0] = str2var(save_dict.level1.coins)
	#	passed_level_array = str2var(save_dict.level1.level_passed)

