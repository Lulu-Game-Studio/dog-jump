extends Area2D

signal coin_collected

func _ready() -> void:
	# IMPORTANTE: conectar bien la señal
	connect("body_entered", Callable(self, "_on_body_entered"))
	add_to_group("coin")  # por si se te olvida en el editor

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		emit_signal("coin_collected")
		queue_free()  # desaparece la moneda
