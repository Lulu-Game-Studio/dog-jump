extends Control

@export var next_level_path := "res://scenes/levels/level2.tscn"

func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	if next_level_path == "":
		$NextLevelButton.visible = false


func show_win():
	get_tree().paused = true
	visible = true

func _on_next_level_button_pressed() -> void:
	get_tree().paused = false
	if next_level_path != "":
		get_tree().change_scene_to_file(next_level_path)

func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")
