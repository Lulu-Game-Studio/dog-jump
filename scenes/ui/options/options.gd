extends Control

@onready var full_screen_button: Button = $BoxOptions/FullScreenButton
@onready var back_button: Button = $BoxOptions/BackButton
var is_fullscreen: bool = false

func _ready() -> void:
	# Detectar estado real al abrir Options
	var current_mode := DisplayServer.window_get_mode()
	is_fullscreen = current_mode == DisplayServer.WINDOW_MODE_FULLSCREEN

	_update_fullscreen_text()


func _on_back_button_pressed() -> void:
	queue_free()


func _on_full_screen_button_pressed() -> void:
	is_fullscreen = !is_fullscreen
	if is_fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	_update_fullscreen_text()


func _update_fullscreen_text() -> void:
	if is_fullscreen:
		full_screen_button.text = "FULL SCREEN: ON"
	else:
		full_screen_button.text = "FULL SCREEN: OFF"
