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
	save_game()
	$Timer.start()

func _on_Timer_timeout():
	PlayerData.is_dialog_playing = false
	get_tree().change_scene("res://Winner_scene.tscn")

func save_game():
	var file = File.new()
	file.open(PlayerData.SAVE_PATH, File.WRITE)
	# JSON doesn't support complex types such as Vector2.
	# `var2str()` can be used to convert any Variant to a String.
	var save_dict = {
		level1 = {
			coins = var2str(PlayerData.coins),
			level_passed = var2str(passed_level1)
		}
	}
	file.store_line(to_json(save_dict))
