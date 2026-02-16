extends CanvasLayer

@onready var coin_label: Label = $MarginContainer/VBoxContainer/CoinLabel
@onready var star_message: Label = $MarginContainer/VBoxContainer/StarMessage

var total_coins: int = 0
var collected_coins: int = 0

func setup(total: int) -> void:
	total_coins = total
	collected_coins = 0
	coin_label.text = "Coins: 0 / %d" % total_coins
	star_message.visible = false
	star_message.text = ""

func add_coin() -> void:
	collected_coins += 1
	coin_label.text = "Coins: %d / %d" % [collected_coins, total_coins]
	
	if collected_coins >= total_coins and total_coins > 0:
		_show_star_message()

func _show_star_message() -> void:
	star_message.text = "A star has appeared!"
	star_message.visible = true
	star_message.modulate.a = 1.0

	var tween := create_tween()
	tween.tween_property(star_message, "modulate:a", 0.0, 3.0)
	tween.finished.connect(func():
		star_message.visible = false
		star_message.modulate.a = 1.0)
