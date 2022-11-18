extends Control

var unlocked_levels = 0
var unlocked_sublevels = 0
var coins = [0, 0]
# Called when the node enters the scene tree for the first time.
func _ready():
	load_game()
	$Panel_levels/coins.text = var2str(coins[0])
	$Panel_levels/coins2.text = var2str(coins[1])

func load_game():
	var file = File.new()
	if file.file_exists(ProjectSettings.globalize_path(PlayerData.SAVE_PATH)):
		file.open(PlayerData.SAVE_PATH, File.READ)
		var save_data = parse_json(file.get_line())
		unlocked_levels = str2var(save_data.number_of_unlocked_levels)
		unlocked_sublevels = str2var(save_data.number_of_unlocked_sublevels)
		coins[0] = str2var(save_data.coins_level_1)
		coins[1] = str2var(save_data.coins_level_1_2)
	if unlocked_sublevels >= 2:
		$Panel_levels/level_2.disabled = false
	if unlocked_sublevels >= 3:
		$Panel_levels/level_3.disabled = false

func _on_level_1_pressed():
	get_tree().change_scene("res://Level_1/Level1.tscn")

func _on_level_2_pressed():
	get_tree().change_scene("res://Level_1_2/Level1_2.tscn")

func _on_Back_pressed():
	get_tree().change_scene("res://Levels/Choose_level.tscn")
