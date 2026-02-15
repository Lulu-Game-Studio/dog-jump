extends CanvasLayer

var hearts: Array[TextureRect] = []

func _ready():
	var hbox = $HBoxContainer
	if hbox:
		for child in hbox.get_children():
			if child is TextureRect:
				hearts.append(child)
	
	update_lives(3)

func update_lives(lives: int):
	for i in hearts.size():
		if i < lives:
			hearts[i].modulate = Color.WHITE 
		else:
			hearts[i].modulate = Color.GRAY  
