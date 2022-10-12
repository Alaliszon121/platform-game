extends CanvasLayer

func _ready():
	var eastereggs = PlayerData.coins
	$Panel/easteregg.text = String(eastereggs)

func _on_LinkButton_pressed():
	get_tree().change_scene("res://Level1.tscn")
