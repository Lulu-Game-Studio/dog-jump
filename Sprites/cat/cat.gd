extends CharacterBody2D

# --- Variables de Movimiento ---
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

func _ready():
	objetive = point_b
	is_moving = true
	
	# --- Configuración del Salto Aleatorio ---
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

	# 1. Gravedad y Animación de Salto
	if not is_on_floor():
		velocity.y += gravity * delta
		# Solo activamos la animación de salto si no estamos haciendo otra cosa importante
		if $AnimatedSprite2D.animation != "Jump":
			$AnimatedSprite2D.play("Jump")
		
	# 2. Lógica de Movimiento (Patrulla)
	if is_moving:
		var direction_x = sign(objetive.x - position.x)
		velocity.x = direction_x * SPEED
		
		if is_on_floor():
			$AnimatedSprite2D.play("Walk")
			
		# --- CORRECCIÓN DEL GIRO (FLIP) ---
		# Si camina a la derecha (v > 0) activamos flip, si camina a la izquierda desactivamos.
		if velocity.x != 0:
			$AnimatedSprite2D.flip_h = velocity.x > 0
			
		if abs(position.x - objetive.x) < 10:
			arrive_at_target()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			$AnimatedSprite2D.play("Idle")

	move_and_slide()

# --- Función del Timer (Salto Aleatorio) ---
func _on_jump_timer_timeout():
	if is_on_floor(): 
		velocity.y = jump_force
		# Accedemos al timer (último hijo añadido) para variar el próximo salto
		get_child(-1).wait_time = randf_range(2.0, 6.0) 

func arrive_at_target():
	is_moving = false
	velocity.x = 0
	# Usamos un timer de la escena para la pausa
	await get_tree().create_timer(wait_time).timeout
	# Verificamos que el nodo siga existiendo tras la espera
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
		$AnimatedSprite2D.play("Hit") 
		return
	
	is_dying = true
	is_moving = false
	velocity = Vector2.ZERO
	
	$AnimatedSprite2D.play("Dead")
	await $AnimatedSprite2D.animation_finished
	queue_free()
