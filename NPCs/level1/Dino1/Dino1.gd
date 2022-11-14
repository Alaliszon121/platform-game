extends KinematicBody2D

signal dialogue_start
var passed_level1

func _on_Area2D_body_entered(body):
	if !PlayerData.is_dialog_playing:
		emit_signal("dialogue_start")
		PlayerData.is_dialog_playing = true
		$mark.queue_free()
		var new_dialog = Dialogic.start('Dino1')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, 'dino_gone')

func dino_gone(_timeline_name):
	passed_level1 = true
	can_be_saved()
	$Timer.start()

func _on_Timer_timeout():
	PlayerData.is_dialog_playing = false
	get_tree().change_scene("res://Level_1_2/Level1_2.tscn")

func can_be_saved():
	var file = File.new()
	if file.file_exists(ProjectSettings.globalize_path(PlayerData.SAVE_PATH)):
		file.open(PlayerData.SAVE_PATH, File.READ)
		var save_dict = parse_json(file.get_line())
		if PlayerData.coins > str2var(save_dict.level1.coins):
			save_game_data()
	else:
		save_game_data()

func save_game_data():
	var file = File.new()
	file.open(PlayerData.SAVE_PATH, File.WRITE)
	var save_dict = {
		level1 = {
			coins = var2str(PlayerData.coins),
			level_passed = var2str(passed_level1)
		}
	}
	file.store_line(to_json(save_dict))
