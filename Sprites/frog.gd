extends CharacterBody2D

var damage = 1
var objetive: Vector2 = Vector2.ZERO
@export var point_a = Vector2.ZERO
@export var point_b = Vector2.ZERO
@export var SPEED = 50
@export var wait_time = 1.5
var is_moving = false
var is_waiting = false

func _ready():
	objetive = point_b
	start_moving()

func _physics_process(_delta):
	if is_moving:
		var direction_x = sign(objetive.x - position.x)
		velocity.x = direction_x * SPEED
		
		if velocity.x != 0:
			$AnimatedSprite2D.flip_h = velocity.x > 0
		
		move_and_slide()
		
		if abs(position.x - objetive.x) < 5:
			arrive_at_target()
	else:
		velocity.x = 0

func arrive_at_target():
	is_moving = false
	velocity = Vector2.ZERO
	$AnimatedSprite2D.play("Idle")
	await get_tree().create_timer(wait_time).timeout
	change_direction()

func change_direction():
	if abs(objetive.x - point_a.x) < 1:
		objetive = point_b
	else:
		objetive = point_a
	start_moving()

func start_moving():
	is_moving = true
	$AnimatedSprite2D.play("Move (Jump)")

func _on_timer_timeout():
	pass
