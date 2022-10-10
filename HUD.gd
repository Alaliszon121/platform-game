extends CanvasLayer

var coins = 0

func _ready():
	$Panel/Coins.text = String(coins)
	if coins == 10:
		get_tree().change_scene("res://Level1.tscn")
	
func _on_Coin_coin_collected():
	coins = coins + 1
	_ready()

