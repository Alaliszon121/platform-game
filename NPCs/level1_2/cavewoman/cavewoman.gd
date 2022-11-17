extends StaticBody2D

var tigers_killed = 0
var can_be_played := true

signal dialogue_start
signal dialogue_end

signal stop_fire_timer
signal start_fire_timer

signal cavewoman_rescued

func _ready():
	print(tigers_killed)

func _on_Tiger_save_cavewoman():
	tigers_killed += 1
	if tigers_killed >= 2:
		Dialogic.set_variable('is_cavewoman_rescued', "true")

func _on_Area2D_body_entered(body):
	if not PlayerData.is_dialog_playing and can_be_played:
		PlayerData.is_dialog_playing = true
		var new_dialog = Dialogic.start(name)
		add_child(new_dialog)
		emit_signal("stop_fire_timer")
		emit_signal("dialogue_start")
		can_be_played = false
		new_dialog.connect("timeline_end", self, 'dialog_ended')

func dialog_ended(_timeline_name):
	if Dialogic.get_variable('is_cavewoman_rescued') == "true":
		emit_signal("cavewoman_rescued")
		$Timer.queue_free()
		$mark.queue_free()
	else:
		$Timer.start()
	emit_signal("start_fire_timer")
	emit_signal("dialogue_end")
	PlayerData.is_dialog_playing = false

func _on_Timer_timeout():
	can_be_played = true
