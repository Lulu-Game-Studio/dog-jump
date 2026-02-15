extends Node2D

@export var level_id: String = "level1"
@export var next_level: String = ""

@onready var pause_menu: Control = $CanvasLayer/Pause
@onready var dog: Node = $Dog
@onready var star: Area2D = $Star
@onready var winner: Control = $CanvasLayer/Winner
@onready var loser: Control = $CanvasLayer/Loser

var cat: Node = null

var total_coins: int = 0
var collected_coins: int = 0

func _ready() -> void:
	add_to_group("game_manager")

	cat = get_node_or_null("Cat")

	if dog and dog.has_method("restore_position"):
		dog.restore_position()

	_setup_coins()
	_setup_star()
	_setup_cat()

func _setup_coins() -> void:
	var coins := get_tree().get_nodes_in_group("coin")
	total_coins = coins.size()
	collected_coins = 0

	for c in coins:
		if c.has_signal("coin_collected"):
			if not c.coin_collected.is_connected(_on_coin_collected):
				c.coin_collected.connect(_on_coin_collected)

	if total_coins == 0:
		_show_star()

func _setup_star() -> void:
	if star:
		star.visible = false
		star.set_deferred("monitoring", false)

func _setup_cat() -> void:
	if cat:
		if not cat.tree_exiting.is_connected(_on_cat_removed):
			cat.tree_exiting.connect(_on_cat_removed)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		toggle_pause()

func toggle_pause() -> void:
	get_tree().paused = not get_tree().paused
	if pause_menu:
		pause_menu.visible = get_tree().paused

func _on_coin_collected() -> void:
	collected_coins += 1
	if collected_coins >= total_coins:
		_show_star()

func _show_star() -> void:
	if star:
		star.visible = true
		star.set_deferred("monitoring", true)

func _on_cat_removed() -> void:
	_show_star()

func on_star_reached() -> void:
	if winner and winner.has_method("show_win"):
		winner.show_win()

func win_level() -> void:
	if next_level != "":
		get_tree().change_scene_to_file(next_level)
	else:
		get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")

func show_loser() -> void:
	if loser and loser.has_method("show_lose"):
		loser.show_lose()
