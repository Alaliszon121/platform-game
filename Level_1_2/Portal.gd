extends AnimatedSprite

var unlocked_levels = 2
var unlocked_sublevels = 2
var coins = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

var can_level_progress_be_saved := false
var can_sublevel_progress_be_saved := false
var can_coins_progress_be_saved := false

func _on_Area2D_body_entered(body):
	coins[1] = PlayerData.coins
	can_be_saved()

func can_be_saved():
	var file = File.new()
	if file.file_exists(ProjectSettings.globalize_path(PlayerData.SAVE_PATH)):
		file.open(PlayerData.SAVE_PATH, File.READ)
		var save_data = parse_json(file.get_line())
		if unlocked_levels > str2var(save_data.number_of_unlocked_levels):
			can_level_progress_be_saved = true
		if  unlocked_sublevels > str2var(save_data.number_of_unlocked_sublevels):
			can_sublevel_progress_be_saved = true
		if coins[1] > str2var(save_data.coins_level_1_2):
			can_coins_progress_be_saved = true
		save_data()
	else:
		go_to_next_level()

func save_data():
	var file1 = File.new()
	file1.open(PlayerData.SAVE_PATH, File.READ)
	var save_data = parse_json(file1.get_line())
	if !can_level_progress_be_saved:
		unlocked_levels = str2var(save_data.number_of_unlocked_levels)
		
	if !can_sublevel_progress_be_saved:
		unlocked_sublevels = str2var(save_data.number_of_unlocked_levels)
	
	if !can_coins_progress_be_saved:
		coins[1] = str2var(save_data.coins_level_1_2)
	
	coins[0] = str2var(save_data.coins_level_1)
	
	coins[2] = str2var(save_data.coins_level_2_1)
	coins[3] = str2var(save_data.coins_level_2_2)
	coins[4] = str2var(save_data.coins_level_2_3)
	
	coins[5] = str2var(save_data.coins_level_3_1)
	coins[6] = str2var(save_data.coins_level_3_2)
	coins[7] = str2var(save_data.coins_level_3_3)
	coins[8] = str2var(save_data.coins_level_3_4)
	
	coins[9] = str2var(save_data.coins_level_4_1)
	coins[10] = str2var(save_data.coins_level_4_2)
	coins[11] = str2var(save_data.coins_level_4_3)
	
	coins[12] = str2var(save_data.coins_level_5_1)
	coins[13] = str2var(save_data.coins_level_5_2)
	coins[14] = str2var(save_data.coins_level_5_3)
	
	var file2 = File.new()
	file2.open(PlayerData.SAVE_PATH, File.WRITE)
	save_data = {
		number_of_unlocked_levels = var2str(unlocked_levels),
		number_of_unlocked_sublevels = var2str(unlocked_sublevels),
		coins_level_1 = var2str(coins[0]),
		coins_level_1_2 = var2str(coins[1]),
		coins_level_2_1 = var2str(coins[2]),
		coins_level_2_2 = var2str(coins[3]),
		coins_level_2_3 = var2str(coins[4]),
		coins_level_3_1 = var2str(coins[5]),
		coins_level_3_2 = var2str(coins[6]),
		coins_level_3_3 = var2str(coins[7]),
		coins_level_3_4 = var2str(coins[8]),
		coins_level_4_1 = var2str(coins[9]),
		coins_level_4_2 = var2str(coins[10]),
		coins_level_4_3 = var2str(coins[11]),
		coins_level_5_1 = var2str(coins[12]),
		coins_level_5_2 = var2str(coins[13]),
		coins_level_5_3 = var2str(coins[14])
	}
	file2.store_line(to_json(save_data))
	
	go_to_next_level()

func go_to_next_level():
	get_tree().change_scene("res://Winner_scene.tscn")

