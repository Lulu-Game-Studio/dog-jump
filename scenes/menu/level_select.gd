extends Control

@onready var level1_button: Button = $VBoxContainer/Level1Button
@onready var level2_button: Button = $VBoxContainer/Level2Button
@onready var level3_button: Button = $VBoxContainer/Level3Button

func _ready() -> void:
	_update_buttons()

func _update_buttons() -> void:
	# Level 1 siempre desbloqueado
	level1_button.disabled = false

	# Level 2 solo si max_level_unlocked >= 2
	level2_button.disabled = LevelProgress.max_level_unlocked < 2

	# Level 3 solo si max_level_unlocked >= 3
	level3_button.disabled = LevelProgress.max_level_unlocked < 3


func _on_level_1_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")

func _on_level_2_button_pressed() -> void:
	if level2_button.disabled:
		return
	get_tree().change_scene_to_file("res://scenes/levels/level2.tscn")

func _on_level_3_button_pressed() -> void:
	if level3_button.disabled:
		return
	get_tree().change_scene_to_file("res://scenes/levels/level3.tscn")
