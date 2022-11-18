extends CanvasLayer

enum States {IDLE, COUNTING}
var state

signal has_fire
signal lost_fire

func _ready():
	state = States.IDLE

func _physics_process(_delta):
	match state:
		States.IDLE:
			continue
		States.COUNTING:
			$PanelTimer/Time.text = String(round($Timer.get_time_left()))

func _on_Fire_fire_collected():
	$Timer.start()
	state = States.COUNTING
	visible = true
	emit_signal("has_fire")

func _on_Timer_timeout():
	emit_signal("lost_fire")
	print("koniec odliczania")
	state = States.IDLE
	visible = false

func _stop_fire_timer():
	$Timer.set_paused(true)

func _start_fire_timer():
	$Timer.set_paused(false)
	print($Timer.is_paused())
