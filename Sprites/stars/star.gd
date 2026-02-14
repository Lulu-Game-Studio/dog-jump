extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	monitoring = false 
	
func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("player"):
		return

	var level := get_tree().current_scene
	if level and level.has_method("on_star_reached"):
		level.on_star_reached()
