extends Area2D

signal coin_collected

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	add_to_group("coin")  

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		emit_signal("coin_collected")
		queue_free()
