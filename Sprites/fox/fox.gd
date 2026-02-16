extends CharacterBody2D

var damage = 1
var objetive: Vector2 = Vector2.ZERO
var is_moving = false
var is_waiting = false
var is_dying = false

@export var point_a = Vector2.ZERO
@export var point_b = Vector2.ZERO
@export var SPEED = 50
@export var wait_time = 1.5

func _ready():
	objetive = point_b
	start_moving()
	add_to_group("enemy")

func _physics_process(_delta):
	if is_dying:
		return
	
	if is_moving:
		var direction_x = sign(objetive.x - position.x)
		velocity.x = direction_x * SPEED
		
		if velocity.x != 0:
			$AnimatedSprite2D.flip_h = velocity.x < 0
		
		move_and_slide()
		
		if abs(position.x - objetive.x) < 5:
			arrive_at_target()
	else:
		velocity.x = 0

func arrive_at_target():
	is_moving = false
	velocity = Vector2.ZERO
	
	if not is_dying:  
		$AnimatedSprite2D.play("Idle")
	
	await get_tree().create_timer(wait_time).timeout
	
	if not is_dying:  
		change_direction()

func change_direction():
	if is_dying:  
		return
		
	if abs(objetive.x - point_a.x) < 1:
		objetive = point_b
	else:
		objetive = point_a
	
	start_moving()

func start_moving():
	if is_dying:  
		return
		
	is_moving = true
	$AnimatedSprite2D.play("Walk")

func die_by_stomp():
	if is_dying:
		return
	
	is_dying = true
	is_moving = false
	velocity = Vector2.ZERO
	
	$AudioStreamPlayer2D.play()
	$AnimatedSprite2D.play("Death")
	
	# Esperar a que AMBAS terminen (en paralelo, no en secuencia)
	await $AnimatedSprite2D.animation_finished
	
	# Si el audio sigue sonando, esperar a que termine
	while $AudioStreamPlayer2D.playing:
		await get_tree().process_frame
	
	queue_free()
