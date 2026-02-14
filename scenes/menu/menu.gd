extends Control

@onready var play_button: Button = $ButtonsContainer/PlayButton
@onready var options_button: Button = $ButtonsContainer/OptionsButton
@onready var quit_button: Button = $ButtonsContainer/QuitButton

const LEVEL_SELECT_SCENE := preload("res://scenes/menu/level_select.tscn")
const OPTIONS_SCENE := preload("res://scenes/ui/options/options.tscn")

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(LEVEL_SELECT_SCENE)

func _on_options_button_pressed() -> void:
	var options_scene = preload("res://scenes/ui/options/options.tscn").instantiate()
	add_child(options_scene)



func _on_quit_button_pressed() -> void:
	get_tree().quit()
