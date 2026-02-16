extends Control


func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED

func show_lose():
	get_tree().paused = true
	visible = true

func _on_retry_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")
