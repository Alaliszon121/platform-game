extends CanvasLayer

func _ready():
	PlayerData.coins = 0
	update_coins()

func update_coins():
	$Panel/Coins.text = String(PlayerData.coins)

func _on_Coin_coin_collected():
	PlayerData.coins = PlayerData.coins +1
	print("coin")
	update_coins()

func _on_win_point_body_entered(_body):
	get_tree().change_scene("res://Winner_scene.tscn")
