extends Node2D

@export var level_id: String = "level1"  
@export var next_level: String = "" 

@onready var pause_menu = $CanvasLayer/Pause 
@onready var dog = $Dog

func _ready():
	if dog and dog.has_method("restore_position"):
		dog.restore_position()

func _input(event):
	if event.is_action_pressed("pause"):
		toggle_pause()

func toggle_pause():
	if get_tree().paused:
		pause_menu.close()
	else:
		pause_menu.open()

func win_level():
	if next_level != "":
		get_tree().change_scene_to_file(next_level)
	else:
		get_tree().change_scene_to_file("res://scenes/menu/menu.tscn") 
