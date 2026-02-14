extends Control

func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED

func open():
	get_tree().paused = true
	visible = true

func close():
	get_tree().paused = false
	visible = false

func _on_resume_button_pressed() -> void:
	close()

func _on_options_button_pressed() -> void:
	var options_scene = preload("res://scenes/ui/options/options.tscn").instantiate()
	add_child(options_scene)  

func _on_return_button_pressed() -> void:
	close()
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")
