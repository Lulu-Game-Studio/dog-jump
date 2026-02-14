extends Area2D

@export var damage := 1

var is_on := true

func _ready():
	$AnimationPlayer.play("fire_move")

	_turn_on()

	body_entered.connect(_on_body_entered)
	$OnOffTimer.timeout.connect(_on_OnOffTimer_timeout)


func _on_body_entered(body):
	if is_on and body.is_in_group("player"):
		if body.has_method("take_damage"):
			body.take_damage(damage)
		if body.has_method("apply_knockback_from_hit"):
			body.apply_knockback_from_hit(global_position)


func _on_OnOffTimer_timeout():
	if is_on:
		_turn_off()
	else:
		_turn_on()


func _turn_on():
	is_on = true
	$AnimatedSprite2D.play("fire")   
	$CollisionShape2D.disabled = false 


func _turn_off():
	is_on = false
	$AnimatedSprite2D.play("idle")      
	$CollisionShape2D.disabled = true  
