extends Node2D
@export var level_id: String = "level1"
@export var next_level: String = ""
@export var level_select_scene: String = "res://scenes/menu/level_select.tscn"
@onready var pause_menu: Control = $CanvasLayer/Pause
@onready var dog: Node = $Dog
@onready var cat: CharacterBody2D = $Cat  
@onready var star: Node = $Star
@onready var winner: Control = $CanvasLayer/Winner

func _ready() -> void:
	if dog and dog.has_method("restore_position"):
		dog.restore_position()


	if cat:
		cat.tree_exiting.connect(_on_cat_removed)


	if star:
		star.visible = false
		if star.has_method("set_deferred"):
			star.set_deferred("monitoring", false)
		elif "monitoring" in star:
			star.monitoring = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		toggle_pause()

func toggle_pause() -> void:
	if get_tree().paused:
		pause_menu.close()
	else:
		pause_menu.open()


func _on_cat_removed() -> void:
	_show_star()

func _show_star() -> void:
	if star:
		star.visible = true
		if star.has_method("set_deferred"):
			star.set_deferred("monitoring", true)
		elif "monitoring" in star:
			star.monitoring = true

func on_star_reached() -> void:
	if winner and winner.has_method("show_win"):
		winner.show_win()

func win_level() -> void:
	if next_level != "":
		get_tree().change_scene_to_file(next_level)
	else:
		get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")
