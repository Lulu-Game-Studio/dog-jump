extends Control

@export var current_level_path := "res://scenes/levels/level1.tscn"

func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED

func show_lose():
	get_tree().paused = true
	visible = true

func _on_retry_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(current_level_path)

func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")
