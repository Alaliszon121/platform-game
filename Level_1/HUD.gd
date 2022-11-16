extends CanvasLayer

func _ready():
	PlayerData.coins = 0
	update_coins()

func update_coins():
	$Panel/Coins.text = String(PlayerData.coins)

func _on_Coin_coin_collected():
	PlayerData.coins = PlayerData.coins + 1
	update_coins()

