extends CharacterBody2D

@export var point_a = Vector2.ZERO
@export var point_b = Vector2.ZERO
@export var SPEED = 80
@export var wait_time = 1.5
@export var jump_force = -400.0 
var damage=1

var objetive: Vector2 = Vector2.ZERO
var is_moving = false
var is_waiting = false
var is_dying = false
var life=3

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimatedSprite2D 

func _ready():
	add_to_group("enemy")  
	objetive = point_b
	is_moving = true
	
	var jump_timer = Timer.new()
	add_child(jump_timer)
	jump_timer.wait_time = randf_range(2.0, 5.0) 
	jump_timer.autostart = true
	jump_timer.timeout.connect(_on_jump_timer_timeout)
	jump_timer.start()

func _physics_process(delta):
	if is_dying:
		move_and_slide()
		return

	if not is_on_floor():
		velocity.y += gravity * delta
		if anim.animation != "Jump":
			anim.play("Jump")
		
	if is_moving:
		var direction_x = sign(objetive.x - position.x)
		velocity.x = direction_x * SPEED
		
		if is_on_floor():
			anim.play("Walk")
			
		if velocity.x != 0:
			anim.flip_h = velocity.x > 0
			
		if abs(position.x - objetive.x) < 10:
			arrive_at_target()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			anim.play("Idle")

	move_and_slide()

func _on_jump_timer_timeout():
	if is_on_floor(): 
		velocity.y = jump_force
		get_child(-1).wait_time = randf_range(2.0, 6.0) 

func arrive_at_target():
	is_moving = false
	velocity.x = 0
	await get_tree().create_timer(wait_time).timeout
	if is_inside_tree():
		change_direction()

func change_direction():
	if abs(objetive.x - point_a.x) < 5:
		objetive = point_b
	else:
		objetive = point_a
	is_moving = true

func die_by_stomp():
	if is_dying:
		return
	
	life -= 1
	
	if life > 0:
		play_damage_effect() 
		return
	
	is_dying = true
	is_moving = false
	velocity = Vector2.ZERO
	
	anim.play("Dead")
	$AudioStreamPlayer2D.play()
	await anim.animation_finished
	queue_free()

func play_damage_effect():
	var tween = create_tween()
	anim.modulate = Color.RED
	tween.tween_property(anim, "modulate", Color.WHITE, 0.15)
	$AudioStreamPlayer2D.play()
