extends Control

@export var next_level_path: String = ""
@export var next_level_number: int = 2 

@onready var next_button: Button = $Buttons/NextLevelButton
@onready var menu_button: Button = $Buttons/MenuButton

func _ready() -> void:
	visible = false
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED

	if next_level_path == "":
		next_button.visible = false

func show_win() -> void:
	LevelProgress.unlock_level(next_level_number)

	get_tree().paused = true
	visible = true

func _on_next_level_button_pressed() -> void:
	get_tree().paused = false
	if next_level_path != "":
		get_tree().change_scene_to_file(next_level_path)
	else:
		get_tree().change_scene_to_file("res://scenes/menu/level_select.tscn")

func _on_return_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")
